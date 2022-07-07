#! /bin/bash

function sayi_kontrol () {

  if ! [[ "$tahmin" =~ ^[0-9]+$ ]]

   then 
    echo "hatali giris yaptin tahmin=$tahmin lutfen sayi gir "
    read -p 'Dogru bir sekilde sayi gir aga nolur [1-100] arasinda: ' tahmin
  fi
}

function tahmin_karsilastirma () {

    if [ $tahmin -lt $random ]
      then
      echo "sizin $tahmin'lik tahmininiz aranilan sayinin ALTINDADIR"
      else 
      echo "sizin $tahmin'lik tahmininiz aranilan sayinin ÜSTÜNDEDİR"
    fi

}

function kayit_alma () {
   
    echo -e "oyunu $tahminsayisi. tahminde kazandiniz bunu kayit altina almak ister misiniz?:\c "
    read kayitcevap
    
    case $kayitcevap in
      
      e | E | evet | EVET )
      dosya=scoretable 
        if [ -f $dosya ]
          then 
          touch scoretable 
          echo "$tamisim : $shortdate -----> tahminsayisi:$tahminsayisi" >> scoretable
          echo "Hoscakal"  
          exit 1
          else
          echo "$tamisim : $shortdate -----> tahminsayisi:$tahminsayisi" >> scoretable 
          echo "Hoscakal" 
          exit 1   
        fi
        ;;

      h | H | hayir | HAYİR )
        echo "Hoscakal"
        exit 1
    esac
}

read -p 'isim giriniz:' isim isim2

if [ -z $isim ]
  then
    echo " Lütfen isim giriniz"
    exit 1
  else

    tamisim="$isim"

    if ! [ -z $isim2 ]
      then 
      tamisim="$isim $isim2"
    fi
fi

random=$(( ($RANDOM%100)+1 ))
shortdate=`date | awk '{print $2,$3,$4,$5}'`

read -p ' [1-100] arasinda sistem tarafindan bir sayi tutuldu bulursan kralsin: ' tahmin

sayi_kontrol

tahminsayisi=1

if [ $tahmin -eq $random ]
   then 
   echo "Tebrikler ilk seferde bildiniz"
  kayit_alma
fi

while [[ $tahmin != $random ]]
  do

     echo "tahmin sayisi: $tahminsayisi"
     read -p ' bilemedin tekrar deneyecegiz yeni tahminin kac? ' tahmin
     sayi_kontrol

      tahminsayisi=$(($tahminsayisi+1))

    if [[ $tahminsayisi -eq 3 ]]
      then
      echo "-----------------------------------------------------"
      tahmin_karsilastirma 
      echo "-----------------------------------------------------"
    fi

    if [[ $tahminsayisi -eq 6 ]]
      then
      kopya=$(($random%5)) 
      echo "-----------------------------------------------------------"
      echo "bu bir kopyadir, sayinin 5 ile bolumundan kalan: $kopya"
      echo "-----------------------------------------------------------"
    fi

    if [[ $tahminsayisi -eq 9 ]]
      then
      echo "-----------------------------------------------------"
      tahmin_karsilastirma 
      echo "-----------------------------------------------------"
    fi

    if [[ $tahminsayisi -eq 12 ]]
      then 
      echo "-----------------------------------------------------------"
      echo "ha gayret"
      echo "-----------------------------------------------------------"
    fi

    if [[ $tahminsayisi -eq 15 ]]
      then
      echo "-----------------------------------------------------------"
      echo "--------------------GAME OVER------------------------------"
      echo "-----------------------------------------------------------"
      exit 1
    fi

  done

echo "*********************************************"
echo "Tebrikler"
echo "*********************************************"
kayit_alma