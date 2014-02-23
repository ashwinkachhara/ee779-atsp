function vec = imgToVec(img)
% USAGE: vec = imgToVec(img)
% Given a 112x92 image, this function concatenates the rows and returns a
% 10304x1 vector
    imsize = size(img);
    vec = zeros(imsize(1)*imsize(2),1);
    for i=1:imsize(1),
        for j=1:imsize(2),
            vec((j-1)*112+i) = img(i,j);
        end
    end
end