USR="moustafa"
PASSWORD="1234"
DBNAME="bills" 
T1="invoices"
T2="invoices_details"

#checks 
#	exit 1 can not connect  to data base 
#CHDB=$(mysql -u ${USR} -p${PASSWORD})
#echo ${CHDB}
#[ ${CHDB} -eq 1 ] && exit 1
#echo "hello"


#[[ -n `mysql -u ${USR} -p${PASSWORD}` ]] && exit 1 
echo "hello"
mysql -u ${USR} -p${PASSWORD}  -e "CREATE DATABASE IF NOT EXISTS ${DBNAME}";

mysql -u ${USR} -p${PASSWORD}  -e "CREATE TABLE IF NOT EXISTS ${DBNAME}.${T1}(invID int PRIMARY KEY,custname varchar(100), invdate date, invtotal float )";
mysql -u ${USR} -p${PASSWORD}  -e "CREATE TABLE IF NOT EXISTS ${DBNAME}.${T2}(seq int PRIMARY KEY AUTO_INCREMENT,invID int REFERENCES ${DBNAME}.${T1}(invID), itemname varchar(50), unitprice int, quantity int)";

cat datafile | awk -v USR=${USR} -v PASSWORD=${PASSWORD} -v DBNAME=${DBNAME} -v T1=${T1} -v T2=${T2} -f "awkfile.txt" |mysql -u ${USR} -p${PASSWORD}
# cat datafile | awk -v USR=${USR} -v PASSWORD=${PASSWORD} -v DBNAME=${DBNAME} -v T1=${T1} -v T2=${T2} 'BEGIN{FS=":"} { print "mysql -u $USR -p$PASSWORD  -e  "INSERT INTO $DBNAME.$T1(invID,custname,invdate,invtotal) VALUES($1,"$2",curdate(),$3)";print $1" "$2" "$3}'
# BEGIN{
# FS=":"

# }
# {
# INVID=$1
# CUSTNAME=$2
# INVTOTAL=$3
# mysql -u ${USR} -p${PASSWORD}  -e "INSERT INTO ${DBNAME}.${T1}(invID,custname,invdate,invtotal) VALUES(${INVID},\"${CUSTNAME}\",curdate(),${INVTOTAL})"

# }

    #creat tables if not exists 
    # mysql -u ${USR} -p${PASSWORD}  -e "CREATE TABLE IF NOT EXISTS ${DBNAME}.${T1}(invID int PRIMARY KEY,custname varchar(100), invdate date, invtotal float )";
    # mysql -u ${USR} -p${PASSWORD}  -e "CREATE TABLE IF NOT EXISTS ${DBNAME}.${T2}(seq int PRIMARY KEY AUTO_INCREMENT,invID int REFERENCES ${DBNAME}.${T1}(invID), itemname varchar(50), unitprice int, quantity int)";
 
#mysql -u mysql -u ${USR} -p${PASSWORD} -e "insert into ${DBNAME}.${T1} values{$1,$2,$3}"
