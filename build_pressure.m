function P=build_pressure(F1,h)
if (h>=0.001)&&(h<0.011)
    if (F1>=0)&&(F1<100/3)
        indexes=[1,2,18,17];
    elseif (F1>=100/3)&&(F1<200/3)
        indexes=[2,3,19,18];
    else
        indexes=[3,4,20,19];
    end
elseif (h>=0.011)&&(h<0.021)
    if (F1>=0)&&(F1<100/3)
        indexes=[17,18,34,33];
    elseif (F1>=100/3)&&(F1<200/3)
        indexes=[18,19,35,34];
    else
        indexes=[19,20,36,35];
    end
else
    if (F1>=0)&&(F1<100/3)
        indexes=[33,34,50,49];
    elseif (F1>=100/3)&&(F1<200/3)
        indexes=[34,35,51,50];
    else
        indexes=[35,36,52,51];
    end
end
N=shape_functions_contact(F1,h,indexes);
load('abacus/fingerbitendon_abacus_contact.mat','C_ref')
Pref=C_ref(indexes,:); %#ok<*NODEF>
P=zeros(1111,2);
P(:,1)=Pref{1}(:,1);
for i=1:4
    P(:,2)=P(:,2)+N(i)*Pref{i}(:,2);
end
temp=max(P(:,2));
P=temp;