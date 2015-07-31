function [q,Gq]=vgQ(L)

q=-norm(L.^2,'fro')^2/4;
Gq=-L.^3;

