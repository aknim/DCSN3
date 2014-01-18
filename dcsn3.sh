file=$1;

#yes, right hash declarations
declare -A YES;
declare -A NO;

#root
root_line=`head -1 $file;`;
IFS=","; set ${root_line}; root="$1"; echo ${root};

#initiating hashes
while read line;
do
 IFS=",";
 set ${line};
 question=`echo "$1"|xargs`;
 yes=`echo "$2"|xargs`;
 no=`echo "$3"|xargs`;
 YES[${question}]=${yes};
 NO[${question}]=${no};
done < ${file};


#Main
echo "y-yes. n-no. rest-quit.";
echo "${root}(${YES[${root}]} , ${NO[${root}]})";
prev=${root};
read ans;
while [ "${ans}" == "y"  ] || [ "${ans}" == "n" ]
do
 if [ "${ans}" == "y" ]; then
  curr=${YES[${prev}]}; 
 elif [ "${ans}" == "n" ]; then
  curr=${NO[${prev}]};
 else
  echo "QUITING."; exit;
 fi;

 if [ -z "$curr" ]; then echo "END."; exit; fi; 
 clear;
 yes_child=${YES[${curr}]}; no_child=${NO[${curr}]};
 echo "${curr}(${yes_child} , ${no_child})";
 prev=${curr};
 read ans;
done;
