import cv2

captcha = cv2.imread("captcha.png", cv2.IMREAD_COLOR)

def filterWhite(img):
    sizeX, sizeY, _ = img.shape
    for x in range(0, sizeX):
        for y in range(0, sizeY):
            r, g, b = img[x][y]
            if r != 255 and g != 255 and b != 255:
                img[x][y] = [0, 0, 0]

    return img

num1 = filterWhite(captcha[6 : 17, 4 : 17])
num2 = filterWhite(captcha[6 : 17, 35 : 41])
cv2.imwrite("num1.png", num1)
cv2.imwrite("num2.png", num2)
