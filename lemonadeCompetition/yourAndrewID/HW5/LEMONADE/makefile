LEMONADEFILE=lemonadeCompetition.m \
	compute_scores.m \
	README \
	makefile \
	adversary1.txt \
	adversary2.txt \
	yourAndrewID/HW5/LEMONADE/PickMyLemonadeSpot.sh \
        
demo:
	matlab -nosplash -nodisplay -r "lemonadeCompetition( 7,'yourAndrewID'); exit"

zip: tar 

tar: ${LEMONADEFILE}
	zip lemonadeCompetition.zip ${LEMONADEFILE}
       
spotless: 
	rm -f previous.txt
	rm -f feedback.txt
	rm  -f yourAndrewID/HW5/LEMONADE/previous.txt
	rm  -f yourAndrewID/HW5/LEMONADE/position.txt
