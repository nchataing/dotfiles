echo "\nCopying all resource files..."

mkdir -p ~/.vim
cp -fv vimrc ~/.vimrc
cp -fv *.vim ~/.vim/
cp -rfv autoload/ ~/.vim/

echo "\n!!! Don't forget to run PlugInstall !!!\n"
