clc; clear; clf;
addpath(genpath('./utils/'));

base_dir = './DeformingThings4DMatching/';

%% load the mesh
s1_cate_name = 'prisoner';
s1_id = 10;
s2_cate_name = s1_cate_name;
s2_id = 1;

all_meshes = dir([base_dir, s1_cate_name, '\*.obj']);
s_name = all_meshes(s1_id).name;
S1 = MESH.MESH_IO.read_shape([base_dir,s1_cate_name, '\', s_name]);

all_meshes = dir([base_dir, s2_cate_name, '\*.obj']);
s_name = all_meshes(s2_id).name;
S2 = MESH.MESH_IO.read_shape([base_dir,s2_cate_name, '\', s_name]);
%% load the correspondences
lmk1 = dlmread([base_dir,s1_cate_name, '\corres\', S1.name,'.vts']);
lmk2 = dlmread([base_dir,s2_cate_name, '\corres\', S2.name,'.vts']);
%% construct the map
T12 = nan(S1.nv, 1);
T12(lmk1) = lmk2;
% since the landmarks do not cover the whole surface
% we use nn to interpolate the map
T12 = fast_pMap_NNinterp(T12, S1);

%% visualize the map
figure(2);
subplot(1,2,1);
visualize_map_on_source(S1, S2, T12);
subplot(1,2,2);
visualize_map_on_target(S1, S2, T12);%%
