function N=shape_functions_contact(F1,h,indexes)
f1=linspace(0,100,4);
hrange=linspace(0.001,0.031,4);
[~,f1elems,helems]=meshgrid(zeros(1,4),f1,hrange);
element_area=(100/3)*0.01;
N1=(1/element_area)*(f1elems(indexes(2))-F1)*(helems(indexes(3))-h);
N2=(1/element_area)*(F1-f1elems(indexes(1)))*(helems(indexes(3))-h);
N3=(1/element_area)*(F1-f1elems(indexes(1)))*(h-helems(indexes(1)));
N4=(1/element_area)*(f1elems(indexes(2))-F1)*(h-helems(indexes(1)));
N=[N1,N2,N3,N4];