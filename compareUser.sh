sort -u user1.txt > user1-sort.txt
sort -u user2.txt > user2-sort.txt
comm -3 user1-sort.txt user2-sort.txt
rm -rf user1-sort.txt user2-sort.txt
