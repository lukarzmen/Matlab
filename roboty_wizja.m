I = imread('6f05189c7f92.jpg');

%zadanie 1
imwrite(I, 'nowa_nazwa.png');
[X, map] = imread('nowa_nazwa.png');
subplot(3,3,1)
imshow(I)
%[R, G, B] = ind2rgb(I);
%zadanie 2
%R=X(:,:,1);
%G=X(:,:,2);
%B=X(:,:,3);

%[X map] = rgb2grey(R,G,B);
%obraz szary
S=rgb2gray(I);
subplot(3,3,2)
imshow(S)

W= gray2ind(S);
subplot(3,3,3)
imshow(W)

K=im2bw(I);
subplot(3,3,3)
imshow(K)

subplot(3,3,4)
imhist(S);

subplot(3,3,5)
J = histeq(S)
imshow(J)

%zaszumianie obrazu
%tu dac kolejne figure i pokazac zaszumienia
SZUM = imnoise(S, 'gaussian');
SZUM = imnoise(S, 'localvar');
SZUM = imnoise(S, 'salt & pepper');
SZUM = imnoise(S, 'poisson');
SZUM = imnoise(S, 'speckle');

subplot(3,3,6);
imshow(SZUM)
%figure filtracje
%filtracja obrazu
%dolnoprzepustowy
1/9*ones(3,3);
ones(3);
ans(2,2)=2;
M=ans*1/10;

ones(3);
ans(2,2)=4;
M=ans*1/12;

M=1/16*[1 2 1;
		2 4 2;
		1 2 1];
		
%gornoprzepustowy
M= [-1 -1 -1;
    -1 9 -1; 
    -1 -1 -1];
M = [0 -1 0;
	-1 -5 -1;
	 0 -1 0;];
M = [1 -2 1;
	-2 5 -2;
	1 -2 1;];	 
F1= imfilter(S, M);
subplot(3,3,7);
imshow(F1)

%medianowa
F2= medfilt2(S);
subplot(3,3,8);
imshow(F2)

%operacje morfologiczne
%dac tez inne elementy strukturalne
se1 = strel('square',3)
%SE = strel('diamond',2)
%SE = strel('octagon',3)
figure(2)
dil = imdilate(K, se1)
subplot(3,3,1);
imshow(dil)

err = imerode(K, se1)
subplot(3,3,2);
imshow(err)

close = imclose(K, se1)
subplot(3,3,3);
imshow(close)

open = imopen(K, se1)
subplot(3,3,4);
imshow(open)

%detekcja krawędzi
figure(3)
BW = edge(S, 'sobel')
subplot(3,2,1);
BW = edge(S, 'prewitt')
subplot(3,2,2);
BW = edge(S, 'roberts')
subplot(3,2,3);
BW = edge(S, 'log')
subplot(3,2,4);
BW = edge(S, 'canny')
subplot(3,2,5);

imcontour(K) % obraz w skali szarosci

figure(4)
Ch = corner(S, 'Harris');
subplot(2,1,1);
imshow(Ch)

Ce = corner(S, 'MinimumEigenvalue');
subplot(2,1,2);
imshow(Ce)


