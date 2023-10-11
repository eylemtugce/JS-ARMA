function grid_graph = create_grid(theta, K, scat_std, grid_numx, ...
    grid_numy, limx, limy, is_normalized)
%CREATE_GRID Creates a kNN graph from a grid with some deviation
%
%% Input:
% theta: Gaussian kernel parameter for kNN graph
% K: k of kNN graph
% scat_std: std of noise (0 if grid graph)
% grid_numx: number of elements along x direction
% grid_numy: number of elements along y direction
% limx: boundaries of x direction (2x1)
% limy: boundaries of y direction (2x1)
% is_normalized: True if one wants to have normalized Laplacian

%% Output:
% grid_graph: Struct for the kNN graph from a grid
% Fields:
% UG: laplacian eigenvector
% VG: diagonal laplacian eigenvalues matrix
% LG: laplacian matrix
% is_normalized: true if laplacian is normalized false if laplacian is
% combinatorial
% D: unnormalized diagonal degree matrix
% W: unnormnalized weight matrix
% G: graph struct for visualization purposes
% coords: graph coordinates for visualization purposes

grid_graph = struct();
N = grid_numx * grid_numy;

x = linspace(limx(1),limx(2),grid_numx);
y = linspace(limy(1),limy(2),grid_numy);
[x,y] = meshgrid(x,y');
x = x(:);
y = y(:);

data_set = [x,y];

data_set = data_set + scat_std*1/sqrt(2) * randn(size(data_set));

[x1,x2] = meshgrid(data_set(:,1),data_set(:,1));
[y1,y2] = meshgrid(data_set(:,2),data_set(:,2));
dist = sqrt((x1-x2).^2+(y1-y2).^2);

W = knn_weights(K,N,theta,dist);

D = sum(W);
D = diag(D);

LG = D - W;
if is_normalized
    LG = D^(-0.5) * LG * D^(-0.5);
end
[UG,VG]=eig(LG);
G=graph(W);

grid_graph.UG = UG;
grid_graph.VG = VG;
grid_graph.LG = LG;
grid_graph.is_normalized = is_normalized;
grid_graph.D = D;
grid_graph.W = W;
grid_graph.G = G;
grid_graph.coords = data_set;


end

