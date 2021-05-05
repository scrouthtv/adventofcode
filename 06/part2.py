#!/usr/bin/env python3

f = open("input", 'r')
score = 0

# questions in group
qig = set(())

newgroup = True

while True:
    line = f.readline()
    if not line:
        break

    if line == "\n":
        print(qig)
        score += len(qig)
        qig = set(())
        newgroup = True
    else:
        chars = list(line.strip())
        if newgroup == True:
            for element in chars:
                qig.add(element)
            newgroup = False
        else:
            newqig = qig.copy()
            for element in qig:
                if not element in chars:
                    newqig.remove(element)
            qig = newqig

f.close()
print('Score: {score}'.format(score = score))
