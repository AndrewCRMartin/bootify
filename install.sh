dest=${HOME}/bin
cp *.pl *.pm $dest
(cd $dest; ln -sf bootify.pl bootify)
(cd $dest; ln -sf genquiz.pl genquiz)
mkdir -p $dest/share/bootify
cp share/bootify/* $dest/share/bootify
