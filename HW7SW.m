clc
clear all
%H(X) = H(Y) = n
n = 12;
%R1 & R2, R1+R2=n+3
R2 = 8;
R1 = n+3-R2;
fprintf('n = %d\n',n)
fprintf('Compression rate of X(R1): %d \n',R1)
fprintf('Compression rate of Y(R2): %d \n',R2)
%=====================constructing bins X & Y============================

%size of each bin for y
size_y = (2^n)/2^R2;
gap1 = 8;
%binning for Y
[Y,codeY] = getBin (gap1,size_y,n);

%since x in {y-4,y-3,y-2,y-1,y,y+1,y+2,y+3}
gapX = 8*size_y;
%the abs difference between 2 X is at least gapX
%number of X bins = 2^R1
numXbin = 2^R1;
%size of each bin X
size_x = 2^n/numXbin;
[X,codeX] = getBin (gapX,size_x,n);

% for j1=1:size(X,1)
%     fprintf('Codeword_X: %s;',codeX(j1,:))
%     fprintf('\t')
%     fprintf('BinX:\t')
%     fprintf('%d\t',X(j1,:))
%     fprintf('\n')
% end
% 
% for j=1:size(Y,1)
%     fprintf('Codeword_Y: %s;',codeY(j,:))
%     fprintf('\t')
%     fprintf('BinY:\t')
%     fprintf('%d\t',Y(j,:))
%     fprintf('\n')
% end

%=======================Encoder===========================
%encoder encodes x,y; these two value must in {0,1,2,...,2^n-1};
%also, x and y must agree with their correlation
%x in {y-4; y-3; y-2; y-1; y; y+1; y+2; y+3}
encode_x = 1234;
encode_y = 1236;

fprintf('Encode X: %d\n',encode_x)
fprintf('Encode Y: %d\n',encode_y)

ix = mod(encode_x,gapX);
%[rowY,colY] = find(Y==encode_y); 
iy1 = mod(encode_y,gap1);
iy2 = floor(encode_y/gapX);
iy3 = iy2*gap1;
iy = iy1+iy3;

%========================Decoder=============================
%use binary search to find correlated pair efficiently
%ix & iy are the idex of X & Y bins
selected_binX = X(ix+1,:);
selected_binY = Y(iy+1,:);

fprintf('Selected bin number X: %d\n',ix+1)
fprintf('Selected bin X: ')
fprintf('%d\t',selected_binX)
fprintf('\n')
fprintf('Selected bin number Y: %d\n',iy+1)
fprintf('Selected bin Y: ')
fprintf('%d\t',selected_binY)


lenX = length(selected_binX);
lenY = length(selected_binY);

    for i = 1:lenX
        tempX = selected_binX(i);
        L = 1;
        R = lenY;
        while L<=R
            index = round((L+R)/2);
            tempY = selected_binY(index);
            if tempX >= (tempY- 4) && tempX<= (tempY+3)
                x_recover = tempX;
                y_recover = tempY;
                break
            elseif tempX<(tempY-4)
                 R = index - 1;
            elseif tempX>(tempY+3)
                L = index + 1;
            end
        end
    end
  fprintf('\n')
  fprintf('Recovered X: %d\n',x_recover)
  fprintf('Recovered Y: %d\n',y_recover)
        
        
        
        
        
        
        
    
