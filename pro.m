str='C:\Users\wuw\Desktop\project\gray\';
for i=3620:3621
    try
    I=imread([str,num2str(i),'.jpg']); 
    catch 
        continue;
    end
    img = zeros(size(I));
    img(I > 0) = 1;
    simg = imfilter(img, fspecial('average', [3,3]));
    limg = imfilter(simg, fspecial('laplacian', 0.2));
    figure();
    imshow(limg);
    %imwrite(J,[num2str(i),'.jpg']);
end