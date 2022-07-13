function [h] = plot_func_on_mesh(S,f,alpha)
if nargin < 3, alpha = 0.5; end;
if nargin < 2
    h = trimesh(S.surface.TRIV, S.surface.VERT(:,1), S.surface.VERT(:,2), S.surface.VERT(:,3), ...
        'FaceColor','interp', 'EdgeColor', 'none','FaceAlpha',alpha); axis equal; axis off;
else
    h = trimesh(S.surface.TRIV, S.surface.VERT(:,1), S.surface.VERT(:,2), S.surface.VERT(:,3),f, ...
        'FaceColor','interp', 'EdgeColor', 'none','FaceAlpha',alpha); axis equal; axis off;
end
if isfield(S,'name')
    title(S.name,'Interpreter','none')
end
end