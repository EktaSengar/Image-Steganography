% Loading a test image
%test image is of size 448 by 660 pixels
image = imread('testimage.jpg');
% Resizing the test image to 112X165 pixels
test_image= imresize(image,0.25);
p= test_image;
%computing a global threshold (level) that will be used to convert the test
%image to a binary image
level=graythresh(p);
b=im2bw(p,level);
%finding connected objects
[L , num] = bwlabel(b,8);
num;
% L returns a matrix containing labels for the connected objects in binary
% image
%num returns the number of connected objects
%storing pixel values of objects in an array
for z=1:num
[r,c] = find(L==z);
rc = [r c];
si = size(rc)
n = si(1)
for i= 1:n
obj(z,i) = p(r(i),c(i));
end
end
%isolating the pixel values and calculating mean and variance of each
%object
for i= 1:num
obj1 = obj(i,:)
obj2 = obj1(find(obj1 ~= 0))
st_dev=std2(obj2);
var(i)= st_dev^2;
obj_mean(i)=mean(obj2);
end
var;
obj_mean;
number_of_objects = num;
temp=ones(num)
temp1=temp(1,:)
var;
%taking reciprocal of the variance matrix and adding it to the mean matrix
%to get an index matrix(parameter matrix such that mean + inverse of
%variance is maximum)
var_reciprocal= temp1./var
var_mean= var_reciprocal + obj_mean
var_mean_maxm = max(var_mean)
%calculating the indices of the object with optimum minimum value of
%variance and maximum value of mean
obj_index = find(var_mean==var_mean_maxm)
[r1,c1] = find(L==obj_index);
rc1 = [r1 c1] ; % setting this object as the cover object
si2 = size(rc1)
hiding_capacity = si2(1);
n1 = si2(1)
% Generating a random sequence of message bits
n = n1;
numberOfOnes = n/2
indexes = randperm(n)
message = zeros(1, n);
message(indexes(1:numberOfOnes)) = 1;
message;
%embedding the message bits into the lsb of cover block
for i=1:n1
original(i) = p(rc1(i,1),rc1(i,2));
p(rc1(i,1),rc1(i,2))= p(rc1(i,1),rc1(i,2)) + message(i);
stego(i)=p(rc1(i,1),rc1(i,2));
end
stego_image= p;
subplot(1,2,2), imshow(p); title('Original Image')
subplot(1,2,1), imshow(test_image); title('Stego Image')
number_of_objects
var
obj_mean
var_reciprocal
var_mean
var_mean_maxm
rc1
hiding_capacity
message
original
stego