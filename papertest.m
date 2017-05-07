str='C:\Users\wuw\Desktop\project\gray\';
I1=imread([str,'2002.jpg']);
I=im2bw(I1,0.95);
I4=medfilt2(I);
I3 = imfilter(I, fspecial('average', [3,3]));
subplot(121),imshow(I3);
subplot(122),imshow(I4);
BW21= edge(I,'Canny',0.2) ; %edge ?? Canny ?????????? 0.2 
figure,imshow(BW21);


%%
g1=im2bw(leaf2,0.95);
g2=medfilt2(g1);
% [B,L]=bwboundaries(g1,'noholes');
% imshow(label2rgb(L,@jet,[.5 .5 .5]));
% hold on
% for k=1:length(B)
%     boundary = B{k};
%     plot(boundary(:,2),boundary(:,1), 'w', 'LineWidth',2);
% end

% leaf21=zeros(size(leaf2));
% leaf21(leaf2<255)=1;
leaf32=bwperim(g1,8);
leaf31=edge(g1,'canny');
simg = imfilter(g1, fspecial('average', [3,3]));
limg = imfilter(simg, fspecial('laplacian', 0.2));
ss = imfilter(g1, fspecial('unsharp'),'replicate');

subplot(1,2,1); imshow(leaf32);
subplot(1,2,2); imshow(leaf31);

warning('off', 'Images:initSize:adjustingMag');
% stru1=strel('disk',1); 
% back1=imopen(leaf2,stru1);
% leaf31=imsubtract(leaf2,back1);
% ts1=graythresh(leaf31);
% leaf41=im2bw(leaf31,ts1);
% %imshow(leaf41);
% leafedge=edge(leaf41,'sobel');
% %imshow(leafedge);
% [labeled1 n]=bwlabel(leaf41,8);
% data1=regionprops(labeled1,'basic');
% all1=[data1.Area];Se1=sum(all1);
% g1=im2bw(leaf2,0.95);
% h=fspecial('average',3);   
% g=round(filter2(h,g1));
% c11=bwarea(~g); 