function [] = showimgs(im1, im2)

  rows1 = size(im1,1);
  cols1 = size(im1,2);
  
  rows2 = size(im2,1);
  cols2 = size(im2,2);

  if (cols1 < cols2) 
    imshow([[im1 zeros(rows1, cols2-cols1)]; im2]); 
  elseif (cols1 > cols2) 
    imshow([im1; [im2 zeros(rows2, cols1-cols2)]]); 
  else
    imshow([im1; im2]);
  end