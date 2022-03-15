# perl prog to create batch file to copy directories of mp3 files.
#
# what is beau?  Beau O. was the person wanting a copy of the lecture podcasts under the folder "church".
# There are 4000 mp3s in folder "church".


#open OUT, ">copymp3.command";
open OUT, ">beaump3.command";

open IN, "<artist.txt";
print OUT "#!/bin/sh\n";

chomp (@mp3dir = <IN>);


foreach $dir (@mp3dir)	{
#	print OUT "cp -R \"/Volumes/big/music/$dir\" \"/users/lg/Music/fromdisk\"\n";
	print OUT "cp -R \"/Volumes/big/music/$dir\" \"/Volumes/beau/church\"\n";

}

# chmod 0755, "copymp3.command";
chmod 0755, "beaump3.command";
