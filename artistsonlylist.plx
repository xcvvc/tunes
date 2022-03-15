# perl to read from ~/documents/speeches.xml and write to artist list
#
# need to handle <location> with special %characters

open OUT, "> artist.txt" or die "no open: $!\n";
open IN, "<speeches.xml" or die "no open: $!\n";
until ($line =~ /\s<key>\d+<\/key>\s/)	{
	$line = <IN>;
}

while (<IN>) {
	chomp;
	
#		Playlists is reached at bottom third of file after all songs listed
#		this means no more artist/song left and so start output to OUT

		if (/<key>Playlists.+/)	{

			@songlist = sort @songlist;
			foreach $song (@songlist)	{
				if ($prior eq $song)	{	next;	}
				if ($song =~/<x>(.+)<n>/)	{
					$artist = $1;
					if ($artist ne $priorartist)	{
						print OUT "$1\n";
						$priorartist = $artist;
					}
				}
#				if ($song =~/<n>(.+)<a>/)	{	print OUT "\n  -  $1";	}
#				if ($song =~/<a>(.+)<c>/)	{	print OUT ":  $1";	}
#				if ($song =~/<c>(.+)<\/z/)	{	print OUT "$1\n";	}
#				print OUT "\n";
							
#				$song =~ /<z>(.+)<x>(.+)<n>(.+)<a>(.+)<c>(.+)<\/z>/;

				
			}
			print "$howmany\n";
			exit;
		}	
		
		if (/<dict>/)	{
			$line = '';
			$genre = '';
			$sort = '';
			$artist = '';
			$comments = '';
			$album = '';

			until ($line =~ /<\/dict>/)	{
				$line = <IN>;
				chomp $line;
				
				if ($line =~ /\s+<key>Name.+string>(.+)<.string>/)	{
					$name = $1;
				}
			
				if ($line =~ /\s+<key>Artist.+string>(.+)<.string>/)	{
					$artist = $1;
				}
		
				if ($line =~ /\s+<key>Album.+string>(.+)<.string>/)	{
					$album = $1;
				}
		
				if ($line =~ /\s+<key>Genre.+string>(.+)<.string>/)	{
					$genre = $1;			
				}
		
				if ($line =~ /\s+<key>Comments.+string>(.+)<.string>/)	{
					$comments = $1;
				}
		
				if ($line =~ /\s+<key>Sort Artist.+string>(.+)<.string>/) {
					$sort = $1;

				}
			

			}	#end until </dict>
			
			if (($genre eq 'Church') || ($genre eq 'Gen Conf')) {	
				if ($sort eq '')	{	$sort = $artist;	}
				if ($sort eq '')	{	$sort = $name;		}
				if ($artist eq '')	{	$artist = $sort;	}
				if ($name eq '')	{	$name = $artist;	}
				$song = "<z>$sort<x>$artist<n>$name<a>$album<c>$comments</z>";
				push @songlist, $song;
				$howmany++;
			}

		}	#end if <dict>
}	#end while	
