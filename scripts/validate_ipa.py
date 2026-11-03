import hashlib
import pathlib
import plistlib
import struct
import sys
import zipfile

path = pathlib.Path(sys.argv[1])
with zipfile.ZipFile(path) as archive:
    assert archive.testzip() is None, 'ZIP CRC failure'
    info = plistlib.loads(archive.read('Payload/Beans.app/Info.plist'))
    assert set(info['UIDeviceFamily']) == {1, 2}, 'Missing iPad support'
    assert 'UIInterfaceOrientationLandscapeLeft' in info['UISupportedInterfaceOrientations~ipad']
    binary = archive.read('Payload/Beans.app/' + info['CFBundleExecutable'])
    assert binary[:4] == bytes.fromhex('cffaedfe'), 'Expected arm64 Mach-O'
    offset = 32
    for _ in range(struct.unpack_from('<I', binary, 16)[0]):
        cmd, size = struct.unpack_from('<II', binary, offset)
        assert size >= 8 and offset + size <= len(binary)
        if cmd == 0x2c:
            assert struct.unpack_from('<I', binary, offset + 16)[0] == 0, 'Encrypted executable'
        offset += size
    print('Validated', info['CFBundleShortVersionString'], 'build', info['CFBundleVersion'])
checksum = hashlib.sha256(path.read_bytes()).hexdigest()
path.with_suffix('.ipa.sha256').write_text(checksum + '  ' + path.name + '\n')
print(path.stat().st_size, 'bytes; SHA-256:', checksum)
