import socket


def get_status(host):
    ip = host.interface('eth0').addresses[0]
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((ip, 8543))
    data = s.recv(1024)
    return data.rstrip().decode('utf-8')
