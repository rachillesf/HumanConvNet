function [cordenadas, out] = GetCoordinades(im)

net = load('data/chars-experiment/charscnn.mat'); %carrega a rede
tic %inicia contagem de temp
im = imresize(im,[180 320]);         %redimenciona a um tamanho padrao
out = im;
im = rgb2gray(im);                   %converte para tons de cinza
im = single(im);                     %converte para o tipo single
                            %clona imagem e variavel de saida

%tamanho da janela
size_i = 100;
size_j = 70;

%tamanho do acrescimo a varredura
di = 50;
dj = 10;

pos = [];%inicializa vetor de posicoes


%loop de varredura das slidding windows
    for i = 1:di:(180 - size_i)
        
        for j = 1:dj: (320 - size_j);
       
        x =  im( i:(i+size_i) ,j:(j+size_j) );  %recorta uma janela da imagem
        x = imresize(x,[32,32]);        %analiza na rede neural
        x = 256 * (x - net.imageMean) ;  %pre processamento da imagem
        res = vl_simplenn(net, x) ;      %aplica rede  
        [score,pred] = max(squeeze(res(end).x(1,1,:))); %retorna vetor da classe mais provavel
    
        if (pred==1) %se identificar uma pessoa
           
            %cordenadas do pixel central localizado
            x_cord = round((j+(size_j/2))); 
            y_cord = round((i+(size_i/2))); 
         
            pos = [pos; x_cord y_cord]; %adiciona ao vetor de posições
             
        end
   
        end
    end
 
    
 pos = cluster(pos,50);   %aplica filro nas leituras
[num_reg, ~] = size(pos); %numero de regioes encontradas após o clustering


%desenha marcadores na imagem
radius = ones(num_reg,1).*10; %variavel "raio" do circulo
pos = [pos radius]; 
out= insertShape(out, 'circle', pos, 'LineWidth', 10 );
out = imresize(out,[500 1000]);

%exibe os resutados

imshow(out) 
fprintf('\n foram encontradas %d regioes com pessoas ', num_reg);

if(length(pos)>0)
  cordenadas = pos(:,1:2)

else
    cordenadas = []
end

%limpeza de variaveis
clear di dj i j num_reg pos pred radius res score 
clear size_i size_j x x_cord y_cord net 

toc %tempo de execução
end



