from PIL import Image, ImageDraw
import math
nodes = []

#print("Import from image file? (y/n)")
# if(raw_input() == "n"):
#     print "How many random nodes?"
#     nodes = int(raw_input())
# else:
#     image = Image.open("input.jpg")
#     pix = image.load()

def length(arg0, arg1):
    return math.hypot(abs(arg0[0] - arg1[0]), abs(arg0[1] - arg1[1]))

def pathLength(path, node):
    tempLen = 0
    for i in range(len(path) - 1):
        #print path[i]
        tempLen = tempLen + length(node[path[i]], node[path[i + 1]])
    return tempLen

image = Image.open("input.jpg")
pix = image.load()
draw = ImageDraw.Draw(image)
for x in range(image.size[0]):
    for y in range(image.size[1]):
        if(pix[x, y][0] == 255 and pix[x,y][1] == 255 and pix[x,y][2] == 255):
            nodes.append([x, y])
#print nodes

#print length(nodes[0], nodes[1])

#Recurring distance function

smallestLen = 100000000
smallestPath = None

def solve(curLength, path):

    global nodes
    #print curNode

    for i in range(len(nodes)):
        #print i
        add = True
        #print path
        #print i
        for x in path:
            if x == i:
                #print i
                add = False
        if len(path) == len(nodes):
            global smallestLen
            global smallestPath
            if curLength < smallestLen and curLength != 0:
                smallestLen = curLength
                smallestPath = path
                #print smallestLen
            add = False
                #print smallestLen

        if add:
            go = True
            tempPath = []
            for y in path:
                tempPath.append(y)
            #print path
            tempPath.append(i)

            tempLen = pathLength(tempPath, nodes)
            #print tempLen
            solve(tempLen, tempPath)




solve(0.0, [])
finalPath = []
for i in smallestPath:
    finalPath.append(nodes[i])
for i in range(len(finalPath) - 1):
    draw.line((finalPath[i][0], finalPath[i][1], finalPath[i + 1][0], finalPath[i + 1][1]), fill = (255, 255, 255))

# red = (255, 0, 0)
#
# for i in nodes:
#     pix[i[0], i[1]] = red

image.save("output.jpg")
