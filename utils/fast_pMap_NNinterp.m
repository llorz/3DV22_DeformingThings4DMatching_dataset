function T12 =  fast_pMap_NNinterp(T12_in, S1)
%%
M = S1.surface;
M.n = S1.nv;
march = fastmarchmex('init', int32(M.TRIV-1), double(M.VERT(:,1)), double(M.VERT(:,2)), double(M.VERT(:,3)));


samples = find(isnan(T12_in));
rest = setdiff(1:M.n, samples);

D = zeros(length(samples), length(rest));

for i=1:length(samples)
    source = inf(M.n,1);
    source(samples(i)) = 0;
    d = fastmarchmex('march', march, double(source));
    D(i,:) = d(rest);
end

fastmarchmex('deinit', march);

T12 = T12_in;
[~, vid] = min(D,[],2);
T12(samples) = T12(rest(vid));

end