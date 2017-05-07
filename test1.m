str='C:\Users\wuw\Desktop\project\gray\';
str2='P:\220\project leaf\leaf\Leaves\';
    I=imread([str2,'2457.jpg']);
    Igray=imread([str,'2457.jpg']); 
  %  figure,imshow(I);
    
    Ibw=im2bw(Igray,0.95);
  %  figure,imshow(Igray);
   % figure,imshow(Ibw);
    
    Iaveragefilter=imfilter(Ibw, fspecial('average', [3,3]));
    %figure,imshow(Iaveragefilter);
    
    Ilaplafilter=imfilter(Iaveragefilter, fspecial('laplacian', 0.2));
    Ilaplafilter = 1-Ilaplafilter;
     
    
    Iareaopen=bwareaopen(Ilaplafilter,900);%edge img
    Ibwfill=imfill(Iareaopen,'holes');
figure,imshow(Ibwfill);
