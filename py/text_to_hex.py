a = input()
count = 0
for c in a :
	h = hex(ord(c))
	count = count + 1
	print h[2:] + " ",

print
print count