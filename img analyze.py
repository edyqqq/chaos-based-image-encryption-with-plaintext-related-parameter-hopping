from PIL import Image
import numpy as np
import skimage.measure
import math
import cv2
from skimage.metrics import peak_signal_noise_ratio
from skimage.metrics import structural_similarity as ssim


def sumofpixel(height,width,img1,img2):
    matrix=np.empty([width, height])
    for y in range(0,height):
        for x in range(0,width):
            # print(img1[x,y],img2[x,y])
            if img1[x,y] == img2[x,y]:
                matrix[x,y]=0
            else:
                matrix[x,y]=1
    psum=0
    for y in range(0,height):
        for x in range(0,width):
            psum=matrix[x,y]+psum
    return psum

def npcr(img1,img2):
    
    height = img1.shape[0]
    width = img1.shape[1]

    npcrv = ((sumofpixel(height,width,img1,img2)/(height*width))*100)
    return npcrv

def uaci(img1,img2):
    height,width = img1.shape
    value = 0
    for y in range(height):
        for x in range(width):
            value += (abs(int(img1[x,y])-int(img2[x,y])))

    value = value*100/(width*height*255)
    return value       


def main():
    img1 = cv2.imread('./lena512.png',cv2.IMREAD_COLOR)
    img2 = cv2.imread('./lena512_en.png',cv2.IMREAD_COLOR)
    img3 = cv2.imread('./lena512_en_K2.png',cv2.IMREAD_COLOR)
    print(img1.shape)
    PSNR = peak_signal_noise_ratio(img1, img2)
    SSIM = ssim(img1, img2, multichannel=True)
    print(f'PSNR: {PSNR}')
    print('Entropy:',skimage.measure.shannon_entropy(img2))
    print('SSIM:', SSIM)
    print('R-NPCR:',npcr(img2[:,:,2],img3[:,:,2]))
    print('G-NPCR:',npcr(img2[:,:,1],img3[:,:,1]))
    print('B-NPCR:',npcr(img2[:,:,0],img3[:,:,0]))
    print('R-UACI:',uaci(img2[:,:,2], img3[:,:,2]))
    print('G-UACI:',uaci(img2[:,:,1], img3[:,:,1]))
    print('B-UACI:',uaci(img2[:,:,0], img3[:,:,0]))

if __name__ == '__main__':
    main()        
        