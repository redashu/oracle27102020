import  time,subprocess
while 4 > 3 :
	print("Hello Docker !!")
	time.sleep(2)
	k=subprocess.getoutput('uname -r')
	print("Docker is running on LInux kernel version ",k)
	print("_____________________")
	time.sleep(1)

