////////////////////////////////////TOP MODULE///////////////////////////////////////
module CardMatching	(
    input clk50MHz,
    input rst,
    input btnC,
    input  [7:0] sw,
    output [2:0] red,
    output [2:0] green,
    output [1:0] blue,
    output hsync,
    output vsync
);


    wire clk25MHz;

    clkDivider	M1	(
        .clkIn(clk50MHz),
        .rst(rst),
        .clkOut(clk25MHz)
    );

    vga640x480	M2 (
        .clk25MHz(clk25MHz),
        .rst(rst),
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .btnC(btnC),
        .sw(sw)
    );

endmodule

/////////////////////////////////////////VGA MODULE////////////////////////////////////////
module clkDivider(
    input clkIn,
    input rst,
    output reg clkOut
);

    initial
    clkOut <= 0;

    always@(posedge clkIn or posedge rst) begin
        if(rst == 1)
            clkOut <= 0;
        else
            clkOut <= ~clkOut;
    end

endmodule

//////////////////////////////////////////////VGA MODULE//////////////////////////////////
module vga640x480(
    input clk25MHz,
    input rst,btnC,
    input [7:0] sw,
    output reg [2:0] red,
    output reg [2:0] green,
    output reg [1:0] blue,
    output hsync,
    output vsync
);
    parameter hpulse = 96; // hsync pulse length
    parameter vpulse = 2; // vsync pulse length
    parameter hbp = 144; // end of horizontal back porch //=144
    parameter hfp = 784; // beginning of horizontal front porch //=784
    parameter vbp = 31; // end of vertical back porch//=31
    parameter vfp = 511; // beginning of vertical front porch//=511
    parameter hPixels = 800; // horizontal pixels per line = 800
    parameter vLines = 521; // vertical lines per frame	= 521	
    reg [9:0] hc,vc;
    assign hsync = (hc < hpulse) ? 0:1;
    assign vsync = (vc < vpulse) ? 0:1;
    always @(posedge clk25MHz or posedge rst) begin
        if (rst == 1) begin
            hc <= 0;
            vc <= 0;
        end
        else begin
            if (hc < hPixels - 1)
                hc <= hc + 1;
            else begin
                hc <= 0;
                if (vc < vLines - 1)
                    vc <= vc + 1;
                else
                    vc <= 0;
            end
        end
    end
    
    //////////////////////////////////////////////hocan�n yazd��� k�s�m buraya kadar//////////////////////////////////
    reg [7:0] state,ilk_basilan,ikinci_basilan;
    reg [7:0] durum;
    ///////////////
    reg show1=1'b1;
    reg show2=1'b1;
    reg show3=1'b1;
    reg show4=1'b1;
    //////////////
    reg shw1=1'b1;
    reg shw2=1'b1;
    reg shw3=1'b1;
    reg shw4=1'b1;
    reg shw5=1'b1;
    reg shw6=1'b1;
    reg shw7=1'b1;
    reg shw8=1'b1;
    ////////////////
    reg gizle1=1'b1;
    reg gizle2=1'b1;
    reg gizle3=1'b1;
    reg gizle4=1'b1;
    ////////////////
    reg giz1=1'b1;
    reg giz2=1'b1;
    reg giz3=1'b1;
    reg giz4=1'b1;
    reg giz5=1'b1;
    reg giz6=1'b1;
    reg giz7=1'b1;
    reg giz8=1'b1;
    //////////////
    wire [1:0] renk1,renk2,renk3,renk4;
    wire [1:0] renk5,renk6,renk7,renk8;
    //////////////
    assign renk1=0;
    assign renk2=0;
    assign renk3=2;
    assign renk4=2;
    assign renk5=1;
    assign renk6=1;
    assign renk7=3;
    assign renk8=3;
    //////////////
    reg [3:0] basilan_sayisi,bas_sayisi;
    reg [2:0] ilk_renk,ikinci_renk;
    reg [2:0] firstcolor,secondcolor;
    reg [31:0] bekle=32'd0;
    reg [31:0] bkle=32'd0;
    reg [31:0] dur=32'd0;
    reg kazandin=1'b0; //results
    reg kaybettin=1'b0;
    reg victory=1'b0;
    always @(posedge clk25MHz or posedge rst) begin
        if(rst == 1) begin
            red 	<= 3'b000;
            green <= 3'b000;
            blue 	<= 2'b00;
            show1<=1;
            show2<=1;
            show3<=1;
            show4<=1;
            shw1<=1;
            shw2<=1;
            shw3<=1;
            shw4<=1;
            shw5<=1;
            shw6<=1;
            shw7<=1;
            shw8<=1;
            gizle1<=1;
            gizle2<=1;
            gizle3<=1;
            gizle4<=1;
            giz1<=1;
            giz2<=1;
            giz3<=1;
            giz4<=1;
            giz5<=1;
            giz6<=1;
            giz7<=1;
            giz8<=1;
            basilan_sayisi<=0;
            firstcolor<=6;
            secondcolor<=5;
            ilk_renk<=6;
            ikinci_renk<=5;
            bekle<=32'd0<=0;
            bkle<=32'd0<=0;
            kazandin<=0;
            kaybettin<=0;
            state<=0;
            dur<=0;
            durum<=0;
            victory<=0;
        end
        else begin
            if(!kazandin)begin
                case(state)
                    8'd0:begin
                        basilan_sayisi<=0; //e�er bas�lan s�f�r ise bir sonraki duruma bakmas� i�in state'i artt�r.
                        if(btnC)begin
                            state<=state+1;
                        end
                    end
                    8'd1:	begin
                        if(sw[3]==1'b1)begin
                            gizle1<=0;
                            if(basilan_sayisi==0)begin
                                ilk_renk<=renk1; // o halde ilk a.�lan renk renk 1 olsun
                                ilk_basilan<=1; //
                                state<=state+1;
                            end
                            else begin
                                ikinci_renk<=renk1; //ilk kez kart a�mad�ysak bu ikinci a��lan kartt�r
                                ikinci_basilan<=1;
                                state<=5;
                            end
                            basilan_sayisi<=basilan_sayisi+1; //bas�lm��sa da bas�lmam��sada bas�lan say�s�n� 1 artt�r�yoruz
                        end
                        else
                            state<=state+1;
                    end
                    8'd2:begin
                        if(sw[2]==1'b1)begin
                            gizle2<=0;
                            if(basilan_sayisi==0)begin
                                state<=state+1;
                                ilk_renk<=renk2;
                                ilk_basilan<=2;
                            end
                            else begin //de�ilse se�ilen ikinci kartt�r
                                state<=5;
                                ikinci_renk<=renk2;
                                ikinci_basilan<=2;
                            end
                            basilan_sayisi<=basilan_sayisi+1;
                        end
                        else
                            state<=state+1;
                    end
                    8'd3:begin
                        if(sw[1]==1'b1)begin
                            gizle3<=0;
                            if(basilan_sayisi==0)begin
                                state<=state+1;
                                ilk_renk<=renk3;
                                ilk_basilan<=3;
                            end
                            else begin
                                state<=5;
                                ikinci_renk<=renk3;
                                ikinci_basilan<=3;
                            end
                            basilan_sayisi<=basilan_sayisi+1;
                        end
                        else
                            state<=state+1;
                    end
                    8'd4:begin
                        bekle<=0; /// resette 0 oldu�u i�in silinebilir
                        if(sw[0]==1'b1) begin
                            gizle4<=0;
                            if(basilan_sayisi==0)begin
                                ilk_renk<=renk4;
                                ilk_basilan<=4;
                                state<=0;
                            end
                            else begin
                                state<=5;
                                ikinci_renk<=renk4;
                                ikinci_basilan<=4;
                            end
                            basilan_sayisi<=basilan_sayisi+1;
                        end
                        else
                            state<=state+1;
                    end
                    8'd5:begin
                        if(bekle<=20000000) //10^8ns//------25*10^12------  //kartlar�n e�leme durumlar�na bakmak i�in daha sonra bu de�eri de�i�tirice�im
                            bekle<=bekle+1;
                        else begin
                            if(ilk_renk==6)
                                state<=0;
                            else if(ikinci_renk==5)
                                state<=0;
                            else begin
                                bekle<=0; //10^8 olunca di�er state e ge�
                                state<=state+1;
                            end
                        end
                    end
                    8'd6:begin
                        state<=state+1; //ilk renk ve ikinci renk burada renk1,2,3,4�n de�erlerini tutan de�i�kenler
                        if(ilk_renk==ikinci_renk)begin
                            if(ilk_basilan==1) //ilk bas�lan hangi kart
                                show1<=0; //1. kart� a�ma
                            else if(ilk_basilan==2)
                                show2<=0;
                            else if(ilk_basilan==3)
                                show3<=0;
                            else if(ilk_basilan==4)
                                show4<=0;
                        end
                        else begin
                            gizle4<=1; //kartlar ayn� de�ilse hepsinin tekrar ters d�nme durumu
                            gizle3<=1;
                            gizle2<=1;
                            gizle1<=1;
                        end
                    end
                    8'd7:begin // bu state 6 ile birle�tirilebilir fakat yapamad�m d���ncem bu y�nde
                        bekle<=0;
                        state<=state+1;
                        if(ilk_renk==ikinci_renk)begin
                            if(ikinci_basilan==1)
                                show1<=0;
                            else if(ikinci_basilan==2)
                                show2<=0;
                            else if(ikinci_basilan==3)
                                show3<=0;
                            else if(ikinci_basilan==4)
                                show4<=0;
                        end
                        else begin
                            gizle4<=1;
                            gizle3<=1;
                            gizle2<=1;
                            gizle1<=1;
                        end
                    end
                    8'd8:begin
                        if({show1,show2,show3,show4}==4'b0000)begin //en son hepsinin e�le�me durumu// s�reyi ekledi�imde buran�n b��na s�re 0 dan by�kken diye bir if else atarsam kod do�ru olabilir
                            if(bekle<=20000000) //EKLENEN YER BURASI
                                bekle<=bekle+1;
                            else begin
                                kazandin<=1;
                                kaybettin<=0;
                            end
                        end
                        else //kazandin<=0;        //bu sat�rlar s�rek eklenince aktif edilmeli yoksa oyunu s�n�rs�z oynayabiliriz	//kaybettin<=0;
                            state<=0;
                    end
                    default:begin
                        state<=0;
                    end
                endcase //KARE OLU�TURMA KISMI//
                if(hc>=200 && hc<=400 && vc<=250 && vc>=100)begin
                    if(show1)begin
                        if(!gizle1)begin
                            if(renk1==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk1==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=0;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else if(hc>=500 && hc<=700 && vc<=250 && vc>=100)begin
                    if(show2)begin
                        if(!gizle2)begin
                            if(renk2==0) begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk2==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=0;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else if(hc>=200 && hc<=400 && vc<=450 && vc>=300)begin
                    if(show3)begin
                        if(!gizle3)begin
                            if(renk3==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk3==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=0;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else  if(hc>=500 && hc<=700 && vc<=450 && vc>=300)begin
                    if(show4)begin
                        if(!gizle4)begin
                            if(renk4==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk4==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=0;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else begin
                    red<=0;
                    blue<=0;
                    green<=0;
                end
            end
            else if(kazandin)begin
                dur<=0;
                if(dur<=100000000)begin
                    dur<=dur+1;
                    if(hc>=100 && hc<=700 && vc<=500 && vc>=20)begin
                        red<=0;
                        blue<=0;
                        green<=15;
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else  begin
                    red<=0;
                    blue<=0;
                    green<=0;
                end
                case(durum)
                    8'd0:begin
                        bas_sayisi<=0;
                        if(btnC)begin
                            durum<=durum+1;
                        end
                    end
                    8'd1:begin
                        if(sw[7]==1'b1)begin
                            giz1<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk1;
                                ilk_basilan<=1;
                            end
                            else begin
                                secondcolor<=renk1;
                                ikinci_basilan<=1;
                                durum<=9;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else begin
                            durum<=durum+1;
                        end
                    end
                    8'd2:begin
                        if(sw[6]==1'b1)begin
                            giz2<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk2;
                                ilk_basilan<=2;
                            end
                            else begin
                                secondcolor<=renk2;
                                ikinci_basilan<=2;
                                durum<=9;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd3:begin
                        if(sw[5]==1'b1)begin
                            giz3<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk3;
                                ilk_basilan<=3;
                            end
                            else begin
                                durum<=9;
                                secondcolor<=renk3;
                                ikinci_basilan<=3;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd4:begin
                        bkle<=0;
                        if(sw[4]==1'b1)begin
                            giz4<=0;
                            if(bas_sayisi==0)
                                begin
                                    firstcolor<=renk4;
                                    ilk_basilan<=4;
                                    durum<=durum+1;
                                end
                            else
                                begin
                                    durum<=9;
                                    secondcolor<=renk4;
                                    ikinci_basilan<=4;
                                end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd5:begin
                        if(sw[3]==1'b1)begin
                            giz5<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk5;
                                ilk_basilan<=5;
                            end
                            else begin
                                durum<=9;
                                secondcolor<=renk5;
                                ikinci_basilan<=5;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd6:begin
                        if(sw[2]==1'b1)begin
                            giz6<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk6;
                                ilk_basilan<=6;
                            end
                            else begin
                                durum<=9;
                                secondcolor<=renk6;
                                ikinci_basilan<=6;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd7:begin
                        if(sw[1]==1'b1)begin
                            giz7<=0;
                            if(bas_sayisi==0)begin
                                durum<=durum+1;
                                firstcolor<=renk7;
                                ilk_basilan<=7;
                            end
                            else begin
                                durum<=9;
                                secondcolor<=renk7;
                                ikinci_basilan<=7;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd8:begin
                        bkle<=0;
                        if(sw[0]==1'b1)begin
                            giz8<=0;
                            if(bas_sayisi==0)begin
                                firstcolor<=renk8;
                                ilk_basilan<=8;
                                durum<=durum+1;
                            end
                            else begin
                                durum<=9;
                                secondcolor<=renk8;
                                ikinci_basilan<=8;
                            end
                            bas_sayisi<=bas_sayisi+1;
                        end
                        else
                            durum<=durum+1;
                    end
                    8'd9:begin
                        if(bkle<=10000000) //10^8ns//------25*10^12------  //kartlar�n e�leme durumlar�na bakmak i�in daha sonra bu de�eri de�i�tirice�im
                            bkle<=bkle+1;
                        else begin
                            if(firstcolor==6)
                                durum<=8'd0;
                            else if(secondcolor==5)
                                durum<=8'd0;
                            else begin
                                bkle<=0;
                                durum<=durum+1; //10^8 olunca di�er durum e ge�
                            end
                        end
                    end
                    8'd10:begin
                        durum<=durum+1;
                        if(firstcolor==secondcolor)begin
                            if(ilk_basilan==1)
                                shw1<=0;
                            else if(ilk_basilan==2)
                                shw2<=0;
                            else if(ilk_basilan==3)
                                shw3<=0;
                            else if(ilk_basilan==4)
                                shw4<=0;
                            else if(ilk_basilan==5)
                                shw5<=0;
                            else if(ilk_basilan==6)
                                shw6<=0;
                            else if(ilk_basilan==7)
                                shw7<=0;
                            else if(ilk_basilan==8)
                                shw8<=0;
                        end
                        else begin
                            giz8<=1;
                            giz7<=1;
                            giz6<=1;
                            giz5<=1;
                            giz4<=1;
                            giz3<=1;
                            giz2<=1;
                            giz1<=1;
                        end
                    end
                    8'd11:begin
                        durum<=durum+1;
                        if(firstcolor==secondcolor)begin
                            if(ikinci_basilan==1)
                                shw1<=0;
                            else if(ikinci_basilan==2)
                                shw2<=0;
                            else if(ikinci_basilan==3)
                                shw3<=0;
                            else if(ikinci_basilan==4)
                                shw4<=0;
                            else if(ikinci_basilan==5)
                                shw5<=0;
                            else if(ikinci_basilan==6)
                                shw6<=0;
                            else if(ikinci_basilan==7)
                                shw7<=0;
                            else if(ikinci_basilan==8)
                                shw8<=0;
                        end
                        else begin
                            giz8<=1;
                            giz7<=1;
                            giz6<=1;
                            giz5<=1;
                            giz4<=1;
                            giz3<=1;
                            giz2<=1;
                            giz1<=1;
                        end
                    end
                    8'd12:begin
                        if({shw1,shw2,shw3,shw4,shw5,shw6,shw7,shw8}==8'b00000000)begin
                            victory<=1;
                        end
                        else
                            durum<=0;
                    end
                    default:begin
                        durum<=0;
                    end
                endcase
                if(victory)begin
                    if(hc>=100 && hc<=700 && vc<=500 && vc>=20)begin
                        red<=0;
                        blue<=0;
                        green<=15;
                    end
                    else begin

                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else if(hc>=250 && hc<=350 && vc<=250 && vc>=100)begin
                    if(shw1)begin
                        if(!giz1)begin
                            if(renk1==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk1==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk1==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else if(hc>=375 && hc<=475 && vc<=250 && vc>=100)begin
                    if(shw2)begin
                        if(!giz2)begin
                            if(renk2==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk2==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk2==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else if(hc>=500 && hc<=600 && vc<=250 && vc>=100)begin
                    if(shw3)begin
                        if(!giz3)begin
                            if(renk3==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk3==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk3==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else if(hc>=625 && hc<=725 && vc<=250 && vc>=100)begin
                    if(shw4)begin
                        if(!giz4)begin
                            if(renk4==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk4==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk4==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else if(hc>=250 && hc<=350 && vc<=450 && vc>=300)begin
                    if(shw5)begin
                        if(!giz5)begin
                            if(renk5==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk5==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk5==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else if(hc>=375 && hc<=475 && vc<=450 && vc>=300)begin
                    if(shw6)begin
                        if(!giz6)begin
                            if(renk6==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk6==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk6==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else if(hc>=500 && hc<=600 && vc<=450 && vc>=300)begin
                    if(shw7)begin
                        if(!giz7)begin
                            if(renk7==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk7==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk7==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;

                    end
                end
                else if(hc>=625 && hc<=725 && vc<=450 && vc>=300)begin
                    if(shw8)begin
                        if(!giz8)begin
                            if(renk8==0)begin
                                red<=15;
                                blue<=0;
                                green<=0;
                            end
                            else if(renk8==1)begin
                                red<=0;
                                blue<=15;
                                green<=0;
                            end
                            else if(renk8==2)begin
                                red<=0;
                                blue<=0;
                                green<=15;
                            end
                            else begin
                                red<=15;
                                blue<=0;
                                green<=15;
                            end
                        end
                        else begin
                            red<=15;
                            blue<=15;
                            green<=15;
                        end
                    end
                    else begin
                        red<=0;
                        blue<=0;
                        green<=0;
                    end
                end
                else begin
                    red<=0;
                    blue<=0;
                    green<=0;
                end
            end
        end
    end
endmodule
/////////////////////////////////////////NETL�ST/////////////////////////////////////////////
NET clk50MHz	LOC = "B8";
NET rst  		LOC = "G12";

NET red[0]   	LOC = "C14";
NET red[1]   	LOC = "D13";
NET red[2]   	LOC = "F13";

NET green[0] 	LOC = "F14";
NET green[1] 	LOC = "G13";
NET green[2] 	LOC = "G14";

NET blue[0]  	LOC = "H13";
NET blue[1]  	LOC = "J13";

NET hsync  		LOC = "J14";
NET vsync  		LOC = "K13";

NET sw[7] 		LOC = "N3";
NET sw[6] 		LOC = "E2";
NET sw[5] 		LOC = "F3";
NET sw[4] 		LOC = "G3";
NET sw[3] 		LOC = "B4";
NET sw[2] 		LOC = "K3";
NET sw[1] 		LOC = "L3";
NET sw[0] 		LOC = "P11";
NET btnC		LOC = "A7";
 //////////////////////////////////////////////////////////////
