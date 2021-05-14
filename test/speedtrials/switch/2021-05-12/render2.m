% render2.m --- adapted from
% https://www.mathworks.com/matlabcentral/answers/101346-how-do-i-use-multiple-colormaps-in-a-single-figure-in-r2014a-and-earlier

function render2(xs, ys, zs1, zs2)

figure

% Define a colormap that uses the cool colormap and
% the gray colormap and assign it as the Figure's colormap.
colormap([spring(64).*0.8;winter(64)])

% Produce the two surface plots.
h(1) = mesh(xs, ys, zs1);
hidden off
hold on
h(2) = mesh(xs, ys, zs2);
hidden off
hold off

xlabel 'Number of cases'
ylabel 'Number of iterations'
zlabel 'Speed (if/then = 1.0)'

%set(h(1),'FaceColor','interp','EdgeColor','interp')
%set(h(2),'FaceColor','interp','EdgeColor','interp')
set(h(1),'EdgeColor','interp')
set(h(2),'EdgeColor','interp')
view(3)

% Scale the CData (Color Data) of each plot so that the
% plots have contiguous, nonoverlapping values.  The range
% of each CData should be equal. Here the CDatas are mapped
% to integer values so that they are easier to manage;
% however, this is not necessary.
% Initially, both CDatas are equal to Z.
m = 64;  % 64-elements is each colormap

cmin1 = min(zs1(:));
cmax1 = max(zs1(:));
% CData for surface
C1 = min(m,round((m-1)*(zs1-cmin1)/(cmax1-cmin1))+1);
set(h(1),'CData',C1);

cmin2 = min(zs2(:));
cmax2 = max(zs2(:));
% CData for surface
C2 = m + min(m,round((m-1)*(zs2-cmin2)/(cmax2-cmin2))+1);
set(h(2),'CData',C2);

% Change the CLim property of axes so that it spans the
% CDatas of both objects.

caxis([ min([C1(:);C2(:)]) max([C1(:);C2(:)]) ])

end
