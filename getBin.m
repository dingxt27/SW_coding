function [Bin,codeword] = getBin (gap,SizeofEachBin,n)
    total = 2^n;
    p = total/(gap*SizeofEachBin);%num of block among whole bin
    a = zeros(p,1);
    for i = 0:p-1
        a(i+1) = gap*SizeofEachBin*i;%get blocks of Bins, for example, if num of Y bins = 16,
                                     %the whole bin-block is divided into 2
                                     %parts, [0,128]
    end

    Bin = zeros(1,SizeofEachBin);
    for k1=1:p
        index1 = a(k1);
        %index2 = a(k1+1);
        subY = zeros(gap,SizeofEachBin);
        for k2 = 1:gap
            for k3 = 1:SizeofEachBin
                subY(k2,k3) = index1+(k2-1)+gap*(k3-1);
            end
        end
        Bin = [Bin;subY];
    end

    Bin = Bin(2:end,:); %Bins of Y
    
    n = size(Bin,1);
    for j=1:n
        codeword(j,:) = dec2bin(j-1,log2(n));
    end
    