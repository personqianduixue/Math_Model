#!/usr/bin/python3
import os,stat
from PIL import Image

def main():
    Players=["D1","D2","D3","D4","M1","M3","M4","M6","F1","F2","G1"]
    Single_width=2919
    Single_height=1970
    NewImage = Image.new('RGBA', (Single_width * 4, Single_height * 4))
    for i in range(8):
        temp=Image.open("./"+Players[i]+"'s HeatMap.png")
        NewImage.paste(temp,(((i//4)+1)*Single_width,(i%4)*Single_height),temp)
    for i in range(8,10):
        temp=Image.open("./"+Players[i]+"'s HeatMap.png")
        NewImage.paste(temp,(((i//4)+1)*Single_width,int((0.5+(i-8)*2)*Single_height)),temp)
    temp=Image.open("./"+Players[10]+"'s HeatMap.png")
    NewImage.paste(temp,(0,int(1.5*Single_height)),temp)
    NewImage.save("./temp1.png")
    #os.chmod("./temp.png",stat.S_IRWXU|stat.S_IRWXG|stat.S_IRWXO)

if __name__ == "__main__":
    main()