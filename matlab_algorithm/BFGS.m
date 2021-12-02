%f��ʾf���ʽ
%H0��ʾ��ʼ�ĺ�ɭ����
%x0��ʾ��ʼ�ĵ����� Ϊ������
%m��ʾ�����ĸ���
%k��ʾ��������
%X�洢ÿ�ε�����x,FΪ����ֵ��GΪÿ�ε��ݶȣ�HΪ��ɭ��HNΪ��ɭ�������
function[X, H, F, G,HN] = BFGS(f,H0,x0,m,k)
    x1 = sym('x',[1,m]);
    %f = (x1(1) - 3)^4 + (x1(1) - 3*x1(2))^2;
    c = num2cell(x1);
    g = sym('x',[m,1]);
    X = zeros(m, k+1);
    F = zeros(1, k+1);
    G = zeros(m, k+1);
    H = zeros( m, m, k+1);
    HN = zeros( m, m, k+1);
    
    X(:,1) = x0;
    F(1,1) = subs(f,c,{X(:,1)'});
    h = hessian(f,x1);%��ɭ����
    H(:,:,1) = subs(h,c,{X(:,1)'});
    HN(:,:,1) = inv(H(:,:,1));
    for n = 1:m
        g(n) = diff(f,x1(n));
    end
     G(:,1) = subs(g,c,{X(:,1)'});
    for n = 1:k
        X(:,n+1) = X(:,n) - (H(:,:,n))\G(:,n);
        F(1,n+1) = subs(f,c,{X(:,n+1)'}); 
        G(:,n+1) = subs(g,c,{X(:,n+1)'});
        s = X(:,n+1) - X(:,n);
        q = G(:,n+1) - G(:,n);
        H(:,:,n+1) = H(:,:,n) + (q * q')./(q' * s) - (H(:,:,n) * s * s' * H(:,:,n)')./(s' * H(:,:,n) * s);
        HN(:,:,n+1) = inv(H(:,:,n+1));
    end
end