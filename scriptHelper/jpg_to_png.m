f=dir('../hep2go/*.jpg');
fil={f.name};  
path = '../hep2go/';
new_path = '../hep2go/png/';
for k=1:numel(fil)
  file=fil{k};
  new_file=strrep(strcat(new_path,file),'.jpg','.png');
  im=imread(strcat(path,file));
  imwrite(im,new_file);
end