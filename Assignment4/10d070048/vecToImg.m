function img = vecToImg(vec)
% USAGE: img = vecToImg(vec)
% Given a 10304x1 vector, this function converts it into a 112x92 image
    img = zeros(112,92);
    for i=1:112,
        for j=1:92,
            img(i,j) = vec((j-1)*112+i);
        end
    end      
end