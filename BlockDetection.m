%loading a test image
%test image is of size 32x32 pixels
RGB=imread('testimage.png');
%separating the image into red, blue and green components
R=RGB(:,:,1);
G=RGB(:,:,2);
B=RGB(:,:,3);
%we've chosen the blue component to embed the message
K = B
%separating the image into 64 blocks of size 4x4 each and calculating
%variance of each block.
i=1;
j=1;
for x=[1:4:32]
for y=[1:4:32]
B1 = K(x:x+3,y:y+3);
b = std2(B1);
u(i,j) = b^2;
j=j+1;
end
i=i+1;
j=1;
end
variance2=u;
v2 = reshape(variance2.',1,[]);
subplot(1,2,1), imshow(B)
subplot(1,2,2), stem(v2)
variance2 %variance matrix
[v2_sort,IX] = sort(v2)
G1=IX
%calculating the mean for each block
i=1;
j=1;
for x=[1:4:32]
for y=[1:4:32]
B1 = K(x:x+3,y:y+3);
a = reshape(B1.',1,[]);
m = mean(a);
w(i,j)=m;
j=j+1;
end
i=i+1;
j=1;
end
mean2=w(1:8,1:8); % mean matrix
m2=reshape(mean2.',1,[])
temp=[1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1;1 1 1 1 1 1 1 1];
%taking reciprocal of the variance matrix and adding it to the mean matrix
%to get an index matrix(parameter matrix such that mean + inverse of variance is maximum)
variance_reciprocal= temp./variance2;
variance_mean=variance_reciprocal + mean2;
maxm_variance_mean1=max(variance_mean);
maxm_variance_mean=max(maxm_variance_mean1); %matrix with maximum index selected
% calculating the indices of the block wrt index matrix with optimum
% minimum value of variance and maximum value of mean.
[i,j]=ind2sub(size(variance_mean), find(variance_mean==maxm_variance_mean))
%calculating the indices of block coresspoding to image matrix
x=(i-1)*4+ 1;
y=(j-1)*4 + 1;
%setting the selected block as the cover image
cover= K(x:x+3,y:y+3)
coverzero=double(cover);
cover1 = std2(cover);
cover_var = cover1^2;
%setting lsb of cover block pixels to 0
coverzero=bitset(coverzero,1,0);
%message bit stream
message = [ 1 0 1 1; 0 0 1 0; 1 0 1 0; 1 1 1 1]
%embedding the message bits into the lsb of cover block
stego = uint8(coverzero+message);
subplot(1,2,1), imshow(stego);title('Stego image')
subplot(1,2,2), imshow(K(x:x+3,y:y+3,:))
L=K;
K(x:x+3,y:y+3)= stego;
K_stego= K;
subplot(1,2,1), imshow(K_stego);title('Stego image-blue comp')
subplot(1,2,2), imshow(L); title('original image-blue comp')
RGB1=RGB;
B= K
%displaying the original and stego images in both blue colour component and
%true colours.
subplot(2,2,1), imshow(K_stego);title('Stego image-blue comp')
subplot(2,2,2), imshow(L); title('original image-blue comp')
subplot(2,2,3), imshow(RGB);title('Stego image')
subplot(2,2,4), imshow(RGB1); title('original image')
block_selected=reshape(variance_mean.',1,[]);
[C,I] = max(block_selected);
variance2
mean2
variance_mean
index_value=C
block_number=I