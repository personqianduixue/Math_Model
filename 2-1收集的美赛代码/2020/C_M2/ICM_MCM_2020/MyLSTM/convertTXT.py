import os
import codecs
import chardet

def list_folders_files(path):
    """
    """
    list_folders = []
    list_files = []
    for file in os.listdir(path):
        file_path = os.path.join(path, file)
        if os.path.isdir(file_path):
            list_folders.append(file)
        else:
            list_files.append(file)
    return (list_folders, list_files)


def convert(file, in_enc="GBK", out_enc="UTF-8"):
    """
    """
    in_enc = in_enc.upper()
    out_enc = out_enc.upper()
    try:
        print("convert [ " + file.split('\\')[-1] + " ].....From " + in_enc + " --> " + out_enc)
        f = codecs.open(file, 'r', in_enc)
        new_content = f.read()
        codecs.open(file, 'w', out_enc).write(new_content)
    # print (f.read())
    except IOError as err:
        print("I/O error: {0}".format(err))

if __name__ == "__main__":
    print("__main__.start...")
    # path = r'G:\Temp'
    # path = "./s1"
    # path = "./data/test/s1"
    # path = "./data/test/s2"
    # path = "./data/test/s3"
    # path = "./data/test/s4"
    # path = "./data/test/s5"

    # path = "./data/train/s1"
    # path = "./data/train/s2"
    # path = "./data/train/s3"
    # path = "./data/train/s4"
    path = "./data/train/s5"
    (list_folders, list_files) = list_folders_files(path)

    print("Path: " + path)
    for fileName in list_files:
        filePath = path + '\\' + fileName
        with open(filePath, "rb") as f:
            data = f.read()
            codeType = chardet.detect(data)['encoding']
            convert(filePath, codeType, 'UTF-8')
    print("__main__.end...")