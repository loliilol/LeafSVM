str='C:\Users\wuw\Desktop\project\gray\';
feature= zeros(1907,20);
label=zeros(1907,1);
j=1;
for i=1001:3621
    try
    Igray=imread([str,num2str(i),'.jpg']); 
    catch 
        continue;
    end
    if(i==2543)
        Ibw=im2bw(Igray,0.85);
    else
    Ibw=im2bw(Igray,0.95);
    end
    % figure,imshow(Ibw);
    % [rotate]=rotate(Ibw);
    %%%subplot(223),imshow(Ibw);
    Iaveragefilter=imfilter(Ibw, fspecial('average', [3,3]));
    Ilaplafilter=imfilter(Iaveragefilter, fspecial('laplacian', 0.2));
    Iareaopen=bwareaopen(Ilaplafilter,900);%edge img

    Ibwfill=imfill(Iareaopen,'holes');
    leafArea=bwarea(Ibwfill);
    leafPerimeter=sum(sum(Iareaopen==1));

    [r,c]=find(Iareaopen==1);
    [rectx,recty,minBoundRectArea,minBoundRectPerimeter]=minboundrect(c,r,'p');
    %%%subplot(221),imshow(Iareaopen);
    %%%line(rectx,recty);

    d1=((rectx(1,1)-rectx(2,1))^2+(recty(1,1)-recty(2,1))^2)^0.5;
    d2=((rectx(2,1)-rectx(3,1))^2+(recty(2,1)-recty(3,1))^2)^0.5;
    if(d1<d2)
        rectwidth=d1;
        rectlength=d2;
    else
        rectwidth=d2;
        rectlength=d1;
    end
    rectradio=rectlength/rectwidth;

    DT=delaunayTriangulation(c,r);
    [k,HullArea] = convexHull(DT);%v:the area or volume bounded by the convex hull
    %%%subplot(222),imshow(Iareaopen);
    %%%line(c(k),r(k));

    L=bwlabel(Ibwfill);
    STATS = regionprops(L,'EquivDiameter','Solidity','Extent','Eccentricity','ConvexImage','BoundingBox','Centroid','MajorAxisLength','MinorAxisLength');
    % figure,imshow(STATS.ConvexImage);
    SubAreaConvex = HullArea-leafArea;
    HullAreaRatio = leafArea/HullArea;

    L2=bwlabel(STATS.ConvexImage);
    STATS2=regionprops(L2,'Perimeter');
    HullPerimeter = STATS2.Perimeter;

    PerimetertoArea = leafPerimeter/leafArea;
    PerimetertoHull = HullPerimeter/HullArea;
    
    feature(j,:)=[HullArea,HullAreaRatio,HullPerimeter,...
        leafArea,leafPerimeter,minBoundRectArea,minBoundRectPerimeter,...
        PerimetertoArea,PerimetertoHull,rectlength,rectradio,rectwidth,...
        SubAreaConvex,STATS.MajorAxisLength,STATS.MinorAxisLength,...
        STATS.Eccentricity,STATS.EquivDiameter,STATS.Solidity,...
        STATS.Extent,0];
    
   if(i>=1001&&i<1060)
       label(j,1)=1;
    elseif(i>=1060&&i<1123)
            label(j,1)=2;
        elseif(i>=1123&&i<1195)
            label(j,1)=3;
        elseif(i>=1195&&i<1268)
            label(j,1)=4;
        elseif(i>=1268&&i<1324)
            label(j,1)=5;
        elseif(i>=1324&&i<1386)
            label(j,1)=6;
        elseif(i>=1386&&i<1438)
            label(j,1)=7;
        elseif(i>=1438&&i<1497)
            label(j,1)=8;
        elseif(i>=1497&&i<1552)
            label(j,1)=9;
        elseif(i>=1552&&i<2001)
            label(j,1)=10;
        elseif(i>=2001&&i<2051)
            label(j,1)=11;
        elseif(i>=2051&&i<2114)
            label(j,1)=12;
        elseif(i>=2114&&i<2166)
            label(j,1)=13;
        elseif(i>=2166&&i<2231)
            label(j,1)=14;
        elseif(i>=2231&&i<2291)
            label(j,1)=15;
        elseif(i>=2291&&i<2347)
            label(j,1)=16;
        elseif(i>=2347&&i<2424)
            label(j,1)=17;
        elseif(i>=2424&&i<2486)
            label(j,1)=18;
        elseif(i>=2486&&i<2547)
            label(j,1)=19;
        elseif(i>=2547&&i<2616)
            label(j,1)=20;
        elseif(i>=2616&&i<3001)
            label(j,1)=21;
        elseif(i>=3001&&i<3056)
            label(j,1)=22;
        elseif(i>=3056&&i<3111)
            label(j,1)=23;
        elseif(i>=3111&&i<3176)
            label(j,1)=24;
        elseif(i>=3176&&i<3230)
            label(j,1)=25;
        elseif(i>=3230&&i<3282)
            label(j,1)=26;
        elseif(i>=3282&&i<3335)
            label(j,1)=27;
        elseif(i>=3335&&i<3390)
            label(j,1)=28;
        elseif(i>=3390&&i<3447)
            label(j,1)=29;
        elseif(i>=3447&&i<3511)
            label(j,1)=30;
        elseif(i>=3511&&i<3566)
            label(j,1)=31;
        elseif(i>=3566&&i<3622)
            label(j,1)=32;
       
    end
        
    j = j+1;
end

% figure,imshow(I);
% cc=bwconncomp(I3,8);
% n=cc.NumObjects;
% Area=zeros(n,1);
% Perimeter=zeros(n,1);
% MajorAxis=zeros(n,1);
% MinorAxis=zeros(n,1);
% k=regionprops(cc,'Area','Perimeter','MajorAxisLength','MinorAxisLength');
% 
% % I4= edge(I3,'Canny',0.2) ; 
% % J1=strel('line',2,90);
% % J2=strel('line',2,0);
% % I5=imdilate(I4,[J1,J2]);
% % I6=bwareaopen(I5,45);
% % I7=imclearborder(I6);
% % I8=imfill(I7,'holes');
% % 
% % Area=bwarea(I8);
% % Perimeter=sum(sum(I6==1));
% % figure,imshow(I31);
% [r,c]=find(I2==0);
% [rectx,recty,area,perimeter]=minboundrect(c,r,'p');
%subplot(122),imshow(I2);
% line(rectx,recty);