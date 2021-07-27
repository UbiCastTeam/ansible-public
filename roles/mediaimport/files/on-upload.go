package main

import (
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"unicode"

	"github.com/jessevdk/go-flags"
	"golang.org/x/text/transform"
	"golang.org/x/text/unicode/norm"
)

const (
	baseDir       = "/home/ftp/storage"
	incomingDir   = baseDir + "/incoming"
	watchDir      = baseDir + "/watchfolder"
	quarantineDir = baseDir + "/quarantine"
)

func setPermissions(path string) error {
	stat, err := os.Stat(path)
	if err != nil {
		return err
	}

	switch mode := stat.Mode(); {
	case mode.IsDir():
		if err := os.Chmod(path, 0755); err != nil {
			return err
		}
	case mode.IsRegular():
		if err := os.Chmod(path, 0644); err != nil {
			return err
		}
	}

	return nil
}

func cleanName(filename string) string {
	// normalize
	isMn := func(r rune) bool {
		return unicode.Is(unicode.Mn, r)
	}
	t := transform.Chain(norm.NFD, transform.RemoveFunc(isMn), norm.NFC)
	cleanedName, _, _ := transform.String(t, filename)

	// replace non allowed characters
	allowedChars := strings.Split("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_-.", "")
	for _, filenameChar := range strings.Split(cleanedName, "") {
		flagged := false
		for _, allowedChar := range allowedChars {
			if filenameChar == allowedChar {
				flagged = true
			}
		}
		// if not in allowed list replace by underscore
		if !flagged {
			cleanedName = strings.Replace(cleanedName, filenameChar, "_", 1)
		}
	}

	return cleanedName
}

func virusScan(path string) error {
	// will move file into quarantine directory if infected
	cmd := exec.Command(
		"/usr/bin/clamscan",
		"--quiet",
		"--infected",
		"--recursive",
		"--move="+quarantineDir,
		"--max-scantime=600000", // 10 minutes
		"--max-filesize=4000M",
		"--max-scansize=4000M",
		"--max-files=200",
		"--max-recursion=6",
		"--max-dir-recursion=6",
		path,
	)
	err := cmd.Run()

	return err
}

func main() {
	var opts struct {
		Scan bool `short:"s" long:"scan-virus" description:"Scan file for virus"`
		Args struct {
			SrcPaths []string `positional-arg-name:"path" required:"yes" description:"Paths of uploaded files"`
		} `positional-args:"yes"`
	}

	if _, err := flags.Parse(&opts); err != nil {
		os.Exit(1)
	}

	for _, srcPath := range opts.Args.SrcPaths {
		// check that file is into incoming folder
		if !strings.HasPrefix(srcPath, baseDir) {
			log.Fatalln("file not in base dir (" + baseDir + "): " + srcPath)
		}

		// ensure permissions are correct
		if err := setPermissions(srcPath); err != nil {
			log.Fatalln(err)
		}

		// scan for virus if enabled
		if opts.Scan {
			if err := os.MkdirAll(quarantineDir, 0775); err != nil {
				log.Fatalln(err)
			}
			if err := virusScan(srcPath); err != nil {
				log.Fatalln(err)
			}
		}

		// cleanup and set destination path
		srcDir, srcFile := filepath.Split(srcPath)
		dstFile := cleanName(srcFile)
		dstDir := strings.ReplaceAll(srcDir, incomingDir, watchDir)
		dstPath := dstDir + dstFile

		// create destination directory
		if err := os.MkdirAll(dstDir, 0775); err != nil {
			log.Fatalln(err)
		}

		// move file into watchfolder
		if err := os.Rename(srcPath, dstPath); err != nil {
			log.Fatalln(err)
		}

		log.Println(srcPath + " moved to " + dstPath)
	}
}
