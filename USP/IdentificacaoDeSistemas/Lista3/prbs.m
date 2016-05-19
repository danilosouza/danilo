function [ u ] = prbs( N,Tb,a)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    u = idinput(N,'PRBS',[0 1/Tb],[-a a]);
end

