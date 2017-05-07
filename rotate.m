function [rotate]=rotate(im2)
bw=im2;
bw = sum((1-im2).^2, 3) > .5; 
%bw = min( bw, [], 3 ) < 50 ; % dark pixels - intensity lower than 50
[y x] = find( bw ); % note that find returns row-col coordinates.

mx = mean(x);
my = mean(y);
C = [ mean( (x-mx).^2 ),     mean( (x-mx).*(y-my) );...  
      mean( (x-mx).*(y-my) ) mean( (y-my).^2 ) ];
[V D] = eig( C );

quiver( mx([1 1]), my([1 1]), (V(1,:)*D), (V(2,:)*D), .05 );
[~,mxi] = max(diag(D)); % find major axis index: largest eigen-value
or = atan2( V(2,mxi), V(1,mxi) ) * 180/pi ; % convert to degrees for readability

im2 = 1 -im2; 

rotate = imrotate( im2, or-180 );
rotate = 1 - rotate;
% axes(handles.axes2);

% imshow( rotate );  
% set(handles.text3, 'String',or-180);