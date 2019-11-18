
# Set working directory
setwd("/Users/matt/OneDrive/NLSY-79/Propensity/NYLS_propensity")


new_data <- read.table('NYLS_propensity.dat', sep=' ')
names(new_data) <- c('A0002600',
  'R0000100',
  'R0173600',
  'R0214700',
  'R0214800',
  'R2350020',
  'R2509000',
  'R2722500',
  'R2724700',
  'R2724701',
  'R2726800',
  'R2727300',
  'R2731700',
  'R2870200',
  'R2872700',
  'R2872800',
  'R3110200',
  'R3400700',
  'R3403100',
  'R3403200',
  'R3710200',
  'R3896830',
  'R4006600',
  'R4009000',
  'R4009100',
  'R4526500',
  'R5080700',
  'R5083100',
  'R5083200',
  'R5166000',
  'R5168400',
  'R5168500',
  'R5221800',
  'R5821800',
  'R6478700',
  'R6481200',
  'R6481300',
  'R6540400',
  'R7006500',
  'R7008900',
  'R7009000')


# Handle missing values

  new_data[new_data == -1] = NA  # Refused
  new_data[new_data == -2] = NA  # Dont know
  new_data[new_data == -3] = NA  # Invalid missing
  new_data[new_data == -4] = NA  # Valid missing
  new_data[new_data == -5] = NA  # Non-interview


# If there are values not categorized they will be represented as NA

vallabels = function(data) {
  data$A0002600[1.0 <= data$A0002600 & data$A0002600 <= 999.0] <- 1.0
  data$A0002600[1000.0 <= data$A0002600 & data$A0002600 <= 1999.0] <- 1000.0
  data$A0002600[2000.0 <= data$A0002600 & data$A0002600 <= 2999.0] <- 2000.0
  data$A0002600[3000.0 <= data$A0002600 & data$A0002600 <= 3999.0] <- 3000.0
  data$A0002600[4000.0 <= data$A0002600 & data$A0002600 <= 4999.0] <- 4000.0
  data$A0002600[5000.0 <= data$A0002600 & data$A0002600 <= 5999.0] <- 5000.0
  data$A0002600[6000.0 <= data$A0002600 & data$A0002600 <= 6999.0] <- 6000.0
  data$A0002600[7000.0 <= data$A0002600 & data$A0002600 <= 7999.0] <- 7000.0
  data$A0002600[8000.0 <= data$A0002600 & data$A0002600 <= 8999.0] <- 8000.0
  data$A0002600[9000.0 <= data$A0002600 & data$A0002600 <= 9999.0] <- 9000.0
  data$A0002600[10000.0 <= data$A0002600 & data$A0002600 <= 10999.0] <- 10000.0
  data$A0002600[11000.0 <= data$A0002600 & data$A0002600 <= 11999.0] <- 11000.0
  data$A0002600[12000.0 <= data$A0002600 & data$A0002600 <= 12999.0] <- 12000.0
  data$A0002600 <- factor(data$A0002600,
    levels=c(1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,11000.0,12000.0),
    labels=c("1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 10999",
      "11000 TO 11999",
      "12000 TO 12999"))
  data$R0173600 <- factor(data$R0173600,
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0),
    labels=c("CROSS MALE WHITE",
      "CROSS MALE WH. POOR",
      "CROSS MALE BLACK",
      "CROSS MALE HISPANIC",
      "CROSS FEMALE WHITE",
      "CROSS FEMALE WH POOR",
      "CROSS FEMALE BLACK",
      "CROSS FEMALE HISPANIC",
      "SUP MALE WH POOR",
      "SUP MALE BLACK",
      "SUP MALE HISPANIC",
      "SUP FEM WH POOR",
      "SUP FEMALE BLACK",
      "SUP FEMALE HISPANIC",
      "MIL MALE WHITE",
      "MIL MALE BLACK",
      "MIL MALE HISPANIC",
      "MIL FEMALE WHITE",
      "MIL FEMALE BLACK",
      "MIL FEMALE HISPANIC"))
  data$R0214700 <- factor(data$R0214700,
    levels=c(1.0,2.0,3.0),
    labels=c("HISPANIC",
      "BLACK",
      "NON-BLACK, NON-HISPANIC"))
  data$R0214800 <- factor(data$R0214800,
    levels=c(1.0,2.0),
    labels=c("MALE",
      "FEMALE"))
  data$R2350020[1.0 <= data$R2350020 & data$R2350020 <= 49.0] <- 1.0
  data$R2350020[50.0 <= data$R2350020 & data$R2350020 <= 99.0] <- 50.0
  data$R2350020[100.0 <= data$R2350020 & data$R2350020 <= 149.0] <- 100.0
  data$R2350020[150.0 <= data$R2350020 & data$R2350020 <= 199.0] <- 150.0
  data$R2350020[200.0 <= data$R2350020 & data$R2350020 <= 249.0] <- 200.0
  data$R2350020[250.0 <= data$R2350020 & data$R2350020 <= 299.0] <- 250.0
  data$R2350020[300.0 <= data$R2350020 & data$R2350020 <= 349.0] <- 300.0
  data$R2350020[350.0 <= data$R2350020 & data$R2350020 <= 399.0] <- 350.0
  data$R2350020[400.0 <= data$R2350020 & data$R2350020 <= 449.0] <- 400.0
  data$R2350020[450.0 <= data$R2350020 & data$R2350020 <= 499.0] <- 450.0
  data$R2350020[500.0 <= data$R2350020 & data$R2350020 <= 549.0] <- 500.0
  data$R2350020[550.0 <= data$R2350020 & data$R2350020 <= 599.0] <- 550.0
  data$R2350020[600.0 <= data$R2350020 & data$R2350020 <= 649.0] <- 600.0
  data$R2350020[650.0 <= data$R2350020 & data$R2350020 <= 699.0] <- 650.0
  data$R2350020[700.0 <= data$R2350020 & data$R2350020 <= 749.0] <- 700.0
  data$R2350020[750.0 <= data$R2350020 & data$R2350020 <= 799.0] <- 750.0
  data$R2350020[800.0 <= data$R2350020 & data$R2350020 <= 9999999.0] <- 800.0
  data$R2350020 <- factor(data$R2350020,
    levels=c(0.0,1.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0),
    labels=c("0",
      "1 TO 49",
      "50 TO 99",
      "100 TO 149",
      "150 TO 199",
      "200 TO 249",
      "250 TO 299",
      "300 TO 349",
      "350 TO 399",
      "400 TO 449",
      "450 TO 499",
      "500 TO 549",
      "550 TO 599",
      "600 TO 649",
      "650 TO 699",
      "700 TO 749",
      "750 TO 799",
      "800 TO 9999999: 800+"))
  data$R2509000 <- factor(data$R2509000,
    levels=c(0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("NONE",
      "1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YR COL",
      "2ND YR COL",
      "3RD YR COL",
      "4TH YR COL",
      "5TH YR COL",
      "6TH YR COL",
      "7TH YR COL",
      "8TH YR COL OR MORE",
      "UNGRADED"))
  data$R2722500[1.0 <= data$R2722500 & data$R2722500 <= 999.0] <- 1.0
  data$R2722500[1000.0 <= data$R2722500 & data$R2722500 <= 1999.0] <- 1000.0
  data$R2722500[2000.0 <= data$R2722500 & data$R2722500 <= 2999.0] <- 2000.0
  data$R2722500[3000.0 <= data$R2722500 & data$R2722500 <= 3999.0] <- 3000.0
  data$R2722500[4000.0 <= data$R2722500 & data$R2722500 <= 4999.0] <- 4000.0
  data$R2722500[5000.0 <= data$R2722500 & data$R2722500 <= 5999.0] <- 5000.0
  data$R2722500[6000.0 <= data$R2722500 & data$R2722500 <= 6999.0] <- 6000.0
  data$R2722500[7000.0 <= data$R2722500 & data$R2722500 <= 7999.0] <- 7000.0
  data$R2722500[8000.0 <= data$R2722500 & data$R2722500 <= 8999.0] <- 8000.0
  data$R2722500[9000.0 <= data$R2722500 & data$R2722500 <= 9999.0] <- 9000.0
  data$R2722500[10000.0 <= data$R2722500 & data$R2722500 <= 14999.0] <- 10000.0
  data$R2722500[15000.0 <= data$R2722500 & data$R2722500 <= 19999.0] <- 15000.0
  data$R2722500[20000.0 <= data$R2722500 & data$R2722500 <= 24999.0] <- 20000.0
  data$R2722500[25000.0 <= data$R2722500 & data$R2722500 <= 49999.0] <- 25000.0
  data$R2722500[50000.0 <= data$R2722500 & data$R2722500 <= 9999999.0] <- 50000.0
  data$R2722500 <- factor(data$R2722500,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R2724700[1.0 <= data$R2724700 & data$R2724700 <= 999.0] <- 1.0
  data$R2724700[1000.0 <= data$R2724700 & data$R2724700 <= 1999.0] <- 1000.0
  data$R2724700[2000.0 <= data$R2724700 & data$R2724700 <= 2999.0] <- 2000.0
  data$R2724700[3000.0 <= data$R2724700 & data$R2724700 <= 3999.0] <- 3000.0
  data$R2724700[4000.0 <= data$R2724700 & data$R2724700 <= 4999.0] <- 4000.0
  data$R2724700[5000.0 <= data$R2724700 & data$R2724700 <= 5999.0] <- 5000.0
  data$R2724700[6000.0 <= data$R2724700 & data$R2724700 <= 6999.0] <- 6000.0
  data$R2724700[7000.0 <= data$R2724700 & data$R2724700 <= 7999.0] <- 7000.0
  data$R2724700[8000.0 <= data$R2724700 & data$R2724700 <= 8999.0] <- 8000.0
  data$R2724700[9000.0 <= data$R2724700 & data$R2724700 <= 9999.0] <- 9000.0
  data$R2724700[10000.0 <= data$R2724700 & data$R2724700 <= 14999.0] <- 10000.0
  data$R2724700[15000.0 <= data$R2724700 & data$R2724700 <= 19999.0] <- 15000.0
  data$R2724700[20000.0 <= data$R2724700 & data$R2724700 <= 24999.0] <- 20000.0
  data$R2724700[25000.0 <= data$R2724700 & data$R2724700 <= 49999.0] <- 25000.0
  data$R2724700[50000.0 <= data$R2724700 & data$R2724700 <= 9999999.0] <- 50000.0
  data$R2724700 <- factor(data$R2724700,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R2724701[1.0 <= data$R2724701 & data$R2724701 <= 999.0] <- 1.0
  data$R2724701[1000.0 <= data$R2724701 & data$R2724701 <= 1999.0] <- 1000.0
  data$R2724701[2000.0 <= data$R2724701 & data$R2724701 <= 2999.0] <- 2000.0
  data$R2724701[3000.0 <= data$R2724701 & data$R2724701 <= 3999.0] <- 3000.0
  data$R2724701[4000.0 <= data$R2724701 & data$R2724701 <= 4999.0] <- 4000.0
  data$R2724701[5000.0 <= data$R2724701 & data$R2724701 <= 5999.0] <- 5000.0
  data$R2724701[6000.0 <= data$R2724701 & data$R2724701 <= 6999.0] <- 6000.0
  data$R2724701[7000.0 <= data$R2724701 & data$R2724701 <= 7999.0] <- 7000.0
  data$R2724701[8000.0 <= data$R2724701 & data$R2724701 <= 8999.0] <- 8000.0
  data$R2724701[9000.0 <= data$R2724701 & data$R2724701 <= 9999.0] <- 9000.0
  data$R2724701[10000.0 <= data$R2724701 & data$R2724701 <= 14999.0] <- 10000.0
  data$R2724701[15000.0 <= data$R2724701 & data$R2724701 <= 19999.0] <- 15000.0
  data$R2724701[20000.0 <= data$R2724701 & data$R2724701 <= 24999.0] <- 20000.0
  data$R2724701[25000.0 <= data$R2724701 & data$R2724701 <= 49999.0] <- 25000.0
  data$R2724701[50000.0 <= data$R2724701 & data$R2724701 <= 9999999.0] <- 50000.0
  data$R2724701 <- factor(data$R2724701,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R2726800[1.0 <= data$R2726800 & data$R2726800 <= 499.0] <- 1.0
  data$R2726800[500.0 <= data$R2726800 & data$R2726800 <= 999.0] <- 500.0
  data$R2726800[1000.0 <= data$R2726800 & data$R2726800 <= 1499.0] <- 1000.0
  data$R2726800[1500.0 <= data$R2726800 & data$R2726800 <= 1999.0] <- 1500.0
  data$R2726800[2000.0 <= data$R2726800 & data$R2726800 <= 2499.0] <- 2000.0
  data$R2726800[2500.0 <= data$R2726800 & data$R2726800 <= 2999.0] <- 2500.0
  data$R2726800[3000.0 <= data$R2726800 & data$R2726800 <= 3499.0] <- 3000.0
  data$R2726800[3500.0 <= data$R2726800 & data$R2726800 <= 3999.0] <- 3500.0
  data$R2726800[4000.0 <= data$R2726800 & data$R2726800 <= 4499.0] <- 4000.0
  data$R2726800[4500.0 <= data$R2726800 & data$R2726800 <= 4999.0] <- 4500.0
  data$R2726800[5000.0 <= data$R2726800 & data$R2726800 <= 9999999.0] <- 5000.0
  data$R2726800 <- factor(data$R2726800,
    levels=c(0.0,1.0,500.0,1000.0,1500.0,2000.0,2500.0,3000.0,3500.0,4000.0,4500.0,5000.0),
    labels=c("0",
      "1 TO 499",
      "500 TO 999",
      "1000 TO 1499",
      "1500 TO 1999",
      "2000 TO 2499",
      "2500 TO 2999",
      "3000 TO 3499",
      "3500 TO 3999",
      "4000 TO 4499",
      "4500 TO 4999",
      "5000 TO 9999999: 5000+"))
  data$R2727300[1.0 <= data$R2727300 & data$R2727300 <= 499.0] <- 1.0
  data$R2727300[500.0 <= data$R2727300 & data$R2727300 <= 999.0] <- 500.0
  data$R2727300[1000.0 <= data$R2727300 & data$R2727300 <= 1499.0] <- 1000.0
  data$R2727300[1500.0 <= data$R2727300 & data$R2727300 <= 1999.0] <- 1500.0
  data$R2727300[2000.0 <= data$R2727300 & data$R2727300 <= 2499.0] <- 2000.0
  data$R2727300[2500.0 <= data$R2727300 & data$R2727300 <= 2999.0] <- 2500.0
  data$R2727300[3000.0 <= data$R2727300 & data$R2727300 <= 3499.0] <- 3000.0
  data$R2727300[3500.0 <= data$R2727300 & data$R2727300 <= 3999.0] <- 3500.0
  data$R2727300[4000.0 <= data$R2727300 & data$R2727300 <= 4499.0] <- 4000.0
  data$R2727300[4500.0 <= data$R2727300 & data$R2727300 <= 4999.0] <- 4500.0
  data$R2727300[5000.0 <= data$R2727300 & data$R2727300 <= 9999999.0] <- 5000.0
  data$R2727300 <- factor(data$R2727300,
    levels=c(0.0,1.0,500.0,1000.0,1500.0,2000.0,2500.0,3000.0,3500.0,4000.0,4500.0,5000.0),
    labels=c("0",
      "1 TO 499",
      "500 TO 999",
      "1000 TO 1499",
      "1500 TO 1999",
      "2000 TO 2499",
      "2500 TO 2999",
      "3000 TO 3499",
      "3500 TO 3999",
      "4000 TO 4499",
      "4500 TO 4999",
      "5000 TO 9999999: 5000+"))
  data$R2731700[1.0 <= data$R2731700 & data$R2731700 <= 99.0] <- 1.0
  data$R2731700[100.0 <= data$R2731700 & data$R2731700 <= 199.0] <- 100.0
  data$R2731700[200.0 <= data$R2731700 & data$R2731700 <= 299.0] <- 200.0
  data$R2731700[300.0 <= data$R2731700 & data$R2731700 <= 399.0] <- 300.0
  data$R2731700[400.0 <= data$R2731700 & data$R2731700 <= 499.0] <- 400.0
  data$R2731700[500.0 <= data$R2731700 & data$R2731700 <= 599.0] <- 500.0
  data$R2731700[600.0 <= data$R2731700 & data$R2731700 <= 699.0] <- 600.0
  data$R2731700[700.0 <= data$R2731700 & data$R2731700 <= 799.0] <- 700.0
  data$R2731700[800.0 <= data$R2731700 & data$R2731700 <= 899.0] <- 800.0
  data$R2731700[900.0 <= data$R2731700 & data$R2731700 <= 999.0] <- 900.0
  data$R2731700[1000.0 <= data$R2731700 & data$R2731700 <= 9999999.0] <- 1000.0
  data$R2731700 <- factor(data$R2731700,
    levels=c(0.0,1.0,100.0,200.0,300.0,400.0,500.0,600.0,700.0,800.0,900.0,1000.0),
    labels=c("0",
      "1 TO 99",
      "100 TO 199",
      "200 TO 299",
      "300 TO 399",
      "400 TO 499",
      "500 TO 599",
      "600 TO 699",
      "700 TO 799",
      "800 TO 899",
      "900 TO 999",
      "1000 TO 9999999: 1000+"))
  data$R2870200[1.0 <= data$R2870200 & data$R2870200 <= 999.0] <- 1.0
  data$R2870200[1000.0 <= data$R2870200 & data$R2870200 <= 1999.0] <- 1000.0
  data$R2870200[2000.0 <= data$R2870200 & data$R2870200 <= 2999.0] <- 2000.0
  data$R2870200[3000.0 <= data$R2870200 & data$R2870200 <= 3999.0] <- 3000.0
  data$R2870200[4000.0 <= data$R2870200 & data$R2870200 <= 4999.0] <- 4000.0
  data$R2870200[5000.0 <= data$R2870200 & data$R2870200 <= 5999.0] <- 5000.0
  data$R2870200[6000.0 <= data$R2870200 & data$R2870200 <= 6999.0] <- 6000.0
  data$R2870200[7000.0 <= data$R2870200 & data$R2870200 <= 7999.0] <- 7000.0
  data$R2870200[8000.0 <= data$R2870200 & data$R2870200 <= 8999.0] <- 8000.0
  data$R2870200[9000.0 <= data$R2870200 & data$R2870200 <= 9999.0] <- 9000.0
  data$R2870200[10000.0 <= data$R2870200 & data$R2870200 <= 14999.0] <- 10000.0
  data$R2870200[15000.0 <= data$R2870200 & data$R2870200 <= 19999.0] <- 15000.0
  data$R2870200[20000.0 <= data$R2870200 & data$R2870200 <= 24999.0] <- 20000.0
  data$R2870200[25000.0 <= data$R2870200 & data$R2870200 <= 49999.0] <- 25000.0
  data$R2870200[50000.0 <= data$R2870200 & data$R2870200 <= 9999999.0] <- 50000.0
  data$R2870200 <- factor(data$R2870200,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R2872700 <- factor(data$R2872700,
    levels=c(0.0,1.0),
    labels=c("RURAL",
      "URBAN"))
  data$R2872800 <- factor(data$R2872800,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("NOT IN SMSA",
      "SMSA, NOT CENTRAL CITY",
      "SMSA, CENTRAL CITY NOT KNOWN",
      "SMSA, IN CENTRAL CITY"))
  data$R3110200 <- factor(data$R3110200,
    levels=c(0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("NONE",
      "1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YR COL",
      "2ND YR COL",
      "3RD YR COL",
      "4TH YR COL",
      "5TH YR COL",
      "6TH YR COL",
      "7TH YR COL",
      "8TH YR COL OR MORE",
      "UNGRADED"))
  data$R3400700[1.0 <= data$R3400700 & data$R3400700 <= 999.0] <- 1.0
  data$R3400700[1000.0 <= data$R3400700 & data$R3400700 <= 1999.0] <- 1000.0
  data$R3400700[2000.0 <= data$R3400700 & data$R3400700 <= 2999.0] <- 2000.0
  data$R3400700[3000.0 <= data$R3400700 & data$R3400700 <= 3999.0] <- 3000.0
  data$R3400700[4000.0 <= data$R3400700 & data$R3400700 <= 4999.0] <- 4000.0
  data$R3400700[5000.0 <= data$R3400700 & data$R3400700 <= 5999.0] <- 5000.0
  data$R3400700[6000.0 <= data$R3400700 & data$R3400700 <= 6999.0] <- 6000.0
  data$R3400700[7000.0 <= data$R3400700 & data$R3400700 <= 7999.0] <- 7000.0
  data$R3400700[8000.0 <= data$R3400700 & data$R3400700 <= 8999.0] <- 8000.0
  data$R3400700[9000.0 <= data$R3400700 & data$R3400700 <= 9999.0] <- 9000.0
  data$R3400700[10000.0 <= data$R3400700 & data$R3400700 <= 14999.0] <- 10000.0
  data$R3400700[15000.0 <= data$R3400700 & data$R3400700 <= 19999.0] <- 15000.0
  data$R3400700[20000.0 <= data$R3400700 & data$R3400700 <= 24999.0] <- 20000.0
  data$R3400700[25000.0 <= data$R3400700 & data$R3400700 <= 49999.0] <- 25000.0
  data$R3400700[50000.0 <= data$R3400700 & data$R3400700 <= 9999999.0] <- 50000.0
  data$R3400700 <- factor(data$R3400700,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R3403100 <- factor(data$R3403100,
    levels=c(0.0,1.0),
    labels=c("RURAL",
      "URBAN"))
  data$R3403200 <- factor(data$R3403200,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("NOT IN SMSA",
      "SMSA, NOT CENTRAL CITY",
      "SMSA, CENTRAL CITY NOT KNOWN",
      "SMSA, IN CENTRAL CITY"))
  data$R3710200 <- factor(data$R3710200,
    levels=c(0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("NONE",
      "1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YR COL",
      "2ND YR COL",
      "3RD YR COL",
      "4TH YR COL",
      "5TH YR COL",
      "6TH YR COL",
      "7TH YR COL",
      "8TH YR COL OR MORE",
      "UNGRADED"))
  data$R3896830[1.0 <= data$R3896830 & data$R3896830 <= 49.0] <- 1.0
  data$R3896830[50.0 <= data$R3896830 & data$R3896830 <= 99.0] <- 50.0
  data$R3896830[100.0 <= data$R3896830 & data$R3896830 <= 149.0] <- 100.0
  data$R3896830[150.0 <= data$R3896830 & data$R3896830 <= 199.0] <- 150.0
  data$R3896830[200.0 <= data$R3896830 & data$R3896830 <= 249.0] <- 200.0
  data$R3896830[250.0 <= data$R3896830 & data$R3896830 <= 299.0] <- 250.0
  data$R3896830[300.0 <= data$R3896830 & data$R3896830 <= 349.0] <- 300.0
  data$R3896830[350.0 <= data$R3896830 & data$R3896830 <= 399.0] <- 350.0
  data$R3896830[400.0 <= data$R3896830 & data$R3896830 <= 449.0] <- 400.0
  data$R3896830[450.0 <= data$R3896830 & data$R3896830 <= 499.0] <- 450.0
  data$R3896830[500.0 <= data$R3896830 & data$R3896830 <= 549.0] <- 500.0
  data$R3896830[550.0 <= data$R3896830 & data$R3896830 <= 599.0] <- 550.0
  data$R3896830[600.0 <= data$R3896830 & data$R3896830 <= 649.0] <- 600.0
  data$R3896830[650.0 <= data$R3896830 & data$R3896830 <= 699.0] <- 650.0
  data$R3896830[700.0 <= data$R3896830 & data$R3896830 <= 749.0] <- 700.0
  data$R3896830[750.0 <= data$R3896830 & data$R3896830 <= 799.0] <- 750.0
  data$R3896830[800.0 <= data$R3896830 & data$R3896830 <= 9999999.0] <- 800.0
  data$R3896830 <- factor(data$R3896830,
    levels=c(0.0,1.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0),
    labels=c("0",
      "1 TO 49",
      "50 TO 99",
      "100 TO 149",
      "150 TO 199",
      "200 TO 249",
      "250 TO 299",
      "300 TO 349",
      "350 TO 399",
      "400 TO 449",
      "450 TO 499",
      "500 TO 549",
      "550 TO 599",
      "600 TO 649",
      "650 TO 699",
      "700 TO 749",
      "750 TO 799",
      "800 TO 9999999: 800+"))
  data$R4006600[1.0 <= data$R4006600 & data$R4006600 <= 999.0] <- 1.0
  data$R4006600[1000.0 <= data$R4006600 & data$R4006600 <= 1999.0] <- 1000.0
  data$R4006600[2000.0 <= data$R4006600 & data$R4006600 <= 2999.0] <- 2000.0
  data$R4006600[3000.0 <= data$R4006600 & data$R4006600 <= 3999.0] <- 3000.0
  data$R4006600[4000.0 <= data$R4006600 & data$R4006600 <= 4999.0] <- 4000.0
  data$R4006600[5000.0 <= data$R4006600 & data$R4006600 <= 5999.0] <- 5000.0
  data$R4006600[6000.0 <= data$R4006600 & data$R4006600 <= 6999.0] <- 6000.0
  data$R4006600[7000.0 <= data$R4006600 & data$R4006600 <= 7999.0] <- 7000.0
  data$R4006600[8000.0 <= data$R4006600 & data$R4006600 <= 8999.0] <- 8000.0
  data$R4006600[9000.0 <= data$R4006600 & data$R4006600 <= 9999.0] <- 9000.0
  data$R4006600[10000.0 <= data$R4006600 & data$R4006600 <= 14999.0] <- 10000.0
  data$R4006600[15000.0 <= data$R4006600 & data$R4006600 <= 19999.0] <- 15000.0
  data$R4006600[20000.0 <= data$R4006600 & data$R4006600 <= 24999.0] <- 20000.0
  data$R4006600[25000.0 <= data$R4006600 & data$R4006600 <= 49999.0] <- 25000.0
  data$R4006600[50000.0 <= data$R4006600 & data$R4006600 <= 9999999.0] <- 50000.0
  data$R4006600 <- factor(data$R4006600,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 9999999: 50000+"))
  data$R4009000 <- factor(data$R4009000,
    levels=c(0.0,1.0),
    labels=c("RURAL",
      "URBAN"))
  data$R4009100 <- factor(data$R4009100,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("NOT IN SMSA",
      "SMSA, NOT CENTRAL CITY",
      "SMSA, CENTRAL CITY NOT KNOWN",
      "SMSA, IN CENTRAL CITY"))
  data$R4526500 <- factor(data$R4526500,
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YEAR COLLEGE",
      "2ND YEAR COLLEGE",
      "3RD YEAR COLLEGE",
      "4TH YEAR COLLEGE",
      "5TH YEAR COLLEGE",
      "6TH YEAR COLLEGE",
      "7TH YEAR COLLEGE",
      "8TH YEAR COLLEGE OR MORE",
      "UNGRADED"))
  data$R5080700[1.0 <= data$R5080700 & data$R5080700 <= 999.0] <- 1.0
  data$R5080700[1000.0 <= data$R5080700 & data$R5080700 <= 1999.0] <- 1000.0
  data$R5080700[2000.0 <= data$R5080700 & data$R5080700 <= 2999.0] <- 2000.0
  data$R5080700[3000.0 <= data$R5080700 & data$R5080700 <= 3999.0] <- 3000.0
  data$R5080700[4000.0 <= data$R5080700 & data$R5080700 <= 4999.0] <- 4000.0
  data$R5080700[5000.0 <= data$R5080700 & data$R5080700 <= 5999.0] <- 5000.0
  data$R5080700[6000.0 <= data$R5080700 & data$R5080700 <= 6999.0] <- 6000.0
  data$R5080700[7000.0 <= data$R5080700 & data$R5080700 <= 7999.0] <- 7000.0
  data$R5080700[8000.0 <= data$R5080700 & data$R5080700 <= 8999.0] <- 8000.0
  data$R5080700[9000.0 <= data$R5080700 & data$R5080700 <= 9999.0] <- 9000.0
  data$R5080700[10000.0 <= data$R5080700 & data$R5080700 <= 14999.0] <- 10000.0
  data$R5080700[15000.0 <= data$R5080700 & data$R5080700 <= 19999.0] <- 15000.0
  data$R5080700[20000.0 <= data$R5080700 & data$R5080700 <= 24999.0] <- 20000.0
  data$R5080700[25000.0 <= data$R5080700 & data$R5080700 <= 49999.0] <- 25000.0
  data$R5080700[50000.0 <= data$R5080700 & data$R5080700 <= 9.9999999E7] <- 50000.0
  data$R5080700 <- factor(data$R5080700,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 99999999: 50000+"))
  data$R5083100 <- factor(data$R5083100,
    levels=c(0.0,1.0),
    labels=c("0: 0  RURAL",
      "1: 1  URBAN"))
  data$R5083200 <- factor(data$R5083200,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("0: 0  NOT IN SMSA",
      "1: 1  SMSA, NOT CENTRAL CITY",
      "2: 2  SMSA, CENTRAL CITY NOT KNOWN",
      "3: 3  SMSA, IN CENTRAL CITY"))
  data$R5166000[1.0 <= data$R5166000 & data$R5166000 <= 999.0] <- 1.0
  data$R5166000[1000.0 <= data$R5166000 & data$R5166000 <= 1999.0] <- 1000.0
  data$R5166000[2000.0 <= data$R5166000 & data$R5166000 <= 2999.0] <- 2000.0
  data$R5166000[3000.0 <= data$R5166000 & data$R5166000 <= 3999.0] <- 3000.0
  data$R5166000[4000.0 <= data$R5166000 & data$R5166000 <= 4999.0] <- 4000.0
  data$R5166000[5000.0 <= data$R5166000 & data$R5166000 <= 5999.0] <- 5000.0
  data$R5166000[6000.0 <= data$R5166000 & data$R5166000 <= 6999.0] <- 6000.0
  data$R5166000[7000.0 <= data$R5166000 & data$R5166000 <= 7999.0] <- 7000.0
  data$R5166000[8000.0 <= data$R5166000 & data$R5166000 <= 8999.0] <- 8000.0
  data$R5166000[9000.0 <= data$R5166000 & data$R5166000 <= 9999.0] <- 9000.0
  data$R5166000[10000.0 <= data$R5166000 & data$R5166000 <= 14999.0] <- 10000.0
  data$R5166000[15000.0 <= data$R5166000 & data$R5166000 <= 19999.0] <- 15000.0
  data$R5166000[20000.0 <= data$R5166000 & data$R5166000 <= 24999.0] <- 20000.0
  data$R5166000[25000.0 <= data$R5166000 & data$R5166000 <= 49999.0] <- 25000.0
  data$R5166000[50000.0 <= data$R5166000 & data$R5166000 <= 9.9999999E7] <- 50000.0
  data$R5166000 <- factor(data$R5166000,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 99999999: 50000+"))
  data$R5168400 <- factor(data$R5168400,
    levels=c(0.0,1.0),
    labels=c("0: RURAL",
      "1: URBAN"))
  data$R5168500 <- factor(data$R5168500,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("0: NOT IN SMSA",
      "1: SMSA, NOT CENTRAL CITY",
      "2: SMSA, CENTRAL CITY NOT KNOWN",
      "3: SMSA, IN CENTRAL CITY"))
  data$R5221800 <- factor(data$R5221800,
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YEAR COLLEGE",
      "2ND YEAR COLLEGE",
      "3RD YEAR COLLEGE",
      "4TH YEAR COLLEGE",
      "5TH YEAR COLLEGE",
      "6TH YEAR COLLEGE",
      "7TH YEAR COLLEGE",
      "8TH YEAR COLLEGE OR MORE",
      "UNGRADED"))
  data$R5821800 <- factor(data$R5821800,
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YEAR COLLEGE",
      "2ND YEAR COLLEGE",
      "3RD YEAR COLLEGE",
      "4TH YEAR COLLEGE",
      "5TH YEAR COLLEGE",
      "6TH YEAR COLLEGE",
      "7TH YEAR COLLEGE",
      "8TH YEAR COLLEGE OR MORE",
      "UNGRADED"))
  data$R6478700[1.0 <= data$R6478700 & data$R6478700 <= 999.0] <- 1.0
  data$R6478700[1000.0 <= data$R6478700 & data$R6478700 <= 1999.0] <- 1000.0
  data$R6478700[2000.0 <= data$R6478700 & data$R6478700 <= 2999.0] <- 2000.0
  data$R6478700[3000.0 <= data$R6478700 & data$R6478700 <= 3999.0] <- 3000.0
  data$R6478700[4000.0 <= data$R6478700 & data$R6478700 <= 4999.0] <- 4000.0
  data$R6478700[5000.0 <= data$R6478700 & data$R6478700 <= 5999.0] <- 5000.0
  data$R6478700[6000.0 <= data$R6478700 & data$R6478700 <= 6999.0] <- 6000.0
  data$R6478700[7000.0 <= data$R6478700 & data$R6478700 <= 7999.0] <- 7000.0
  data$R6478700[8000.0 <= data$R6478700 & data$R6478700 <= 8999.0] <- 8000.0
  data$R6478700[9000.0 <= data$R6478700 & data$R6478700 <= 9999.0] <- 9000.0
  data$R6478700[10000.0 <= data$R6478700 & data$R6478700 <= 14999.0] <- 10000.0
  data$R6478700[15000.0 <= data$R6478700 & data$R6478700 <= 19999.0] <- 15000.0
  data$R6478700[20000.0 <= data$R6478700 & data$R6478700 <= 24999.0] <- 20000.0
  data$R6478700[25000.0 <= data$R6478700 & data$R6478700 <= 49999.0] <- 25000.0
  data$R6478700[50000.0 <= data$R6478700 & data$R6478700 <= 9.9999999E7] <- 50000.0
  data$R6478700 <- factor(data$R6478700,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 99999999: 50000+"))
  data$R6481200 <- factor(data$R6481200,
    levels=c(0.0,1.0),
    labels=c("0: 0  RURAL",
      "1: 1  URBAN"))
  data$R6481300 <- factor(data$R6481300,
    levels=c(0.0,1.0,2.0,3.0),
    labels=c("0: NOT IN SMSA",
      "1: SMSA, NOT CENTRAL CITY",
      "2: SMSA, CENTRAL CITY NOT KNOWN",
      "3: SMSA, IN CENTRAL CITY"))
  data$R6540400 <- factor(data$R6540400,
    levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0,95.0),
    labels=c("1ST GRADE",
      "2ND GRADE",
      "3RD GRADE",
      "4TH GRADE",
      "5TH GRADE",
      "6TH GRADE",
      "7TH GRADE",
      "8TH GRADE",
      "9TH GRADE",
      "10TH GRADE",
      "11TH GRADE",
      "12TH GRADE",
      "1ST YEAR COLLEGE",
      "2ND YEAR COLLEGE",
      "3RD YEAR COLLEGE",
      "4TH YEAR COLLEGE",
      "5TH YEAR COLLEGE",
      "6TH YEAR COLLEGE",
      "7TH YEAR COLLEGE",
      "8TH YEAR COLLEGE OR MORE",
      "UNGRADED"))
  data$R7006500[1.0 <= data$R7006500 & data$R7006500 <= 999.0] <- 1.0
  data$R7006500[1000.0 <= data$R7006500 & data$R7006500 <= 1999.0] <- 1000.0
  data$R7006500[2000.0 <= data$R7006500 & data$R7006500 <= 2999.0] <- 2000.0
  data$R7006500[3000.0 <= data$R7006500 & data$R7006500 <= 3999.0] <- 3000.0
  data$R7006500[4000.0 <= data$R7006500 & data$R7006500 <= 4999.0] <- 4000.0
  data$R7006500[5000.0 <= data$R7006500 & data$R7006500 <= 5999.0] <- 5000.0
  data$R7006500[6000.0 <= data$R7006500 & data$R7006500 <= 6999.0] <- 6000.0
  data$R7006500[7000.0 <= data$R7006500 & data$R7006500 <= 7999.0] <- 7000.0
  data$R7006500[8000.0 <= data$R7006500 & data$R7006500 <= 8999.0] <- 8000.0
  data$R7006500[9000.0 <= data$R7006500 & data$R7006500 <= 9999.0] <- 9000.0
  data$R7006500[10000.0 <= data$R7006500 & data$R7006500 <= 14999.0] <- 10000.0
  data$R7006500[15000.0 <= data$R7006500 & data$R7006500 <= 19999.0] <- 15000.0
  data$R7006500[20000.0 <= data$R7006500 & data$R7006500 <= 24999.0] <- 20000.0
  data$R7006500[25000.0 <= data$R7006500 & data$R7006500 <= 49999.0] <- 25000.0
  data$R7006500[50000.0 <= data$R7006500 & data$R7006500 <= 9.9999999E7] <- 50000.0
  data$R7006500 <- factor(data$R7006500,
    levels=c(0.0,1.0,1000.0,2000.0,3000.0,4000.0,5000.0,6000.0,7000.0,8000.0,9000.0,10000.0,15000.0,20000.0,25000.0,50000.0),
    labels=c("0",
      "1 TO 999",
      "1000 TO 1999",
      "2000 TO 2999",
      "3000 TO 3999",
      "4000 TO 4999",
      "5000 TO 5999",
      "6000 TO 6999",
      "7000 TO 7999",
      "8000 TO 8999",
      "9000 TO 9999",
      "10000 TO 14999",
      "15000 TO 19999",
      "20000 TO 24999",
      "25000 TO 49999",
      "50000 TO 99999999: 50000+"))
  data$R7008900 <- factor(data$R7008900,
    levels=c(0.0,1.0,2.0),
    labels=c("0: RURAL",
      "1: URBAN",
      "2: UNKNOWN"))
  data$R7009000 <- factor(data$R7009000,
    levels=c(1.0,2.0,3.0,4.0),
    labels=c("1: NOT IN MSA",
      "2: IN MSA, NOT IN CENTRAL CITY",
      "3: IN MSA, IN CENTRAL CITY",
      "4: IN MSA, CENTRAL CITY NOT KNOWN"))
  return(data)
}

varlabels <- c("VERSION_R26_1 2014",
  "ID# (1-12686) 79",
  "SAMPLE ID  79 INT",
  "RACL/ETHNIC COHORT /SCRNR 79",
  "SEX OF R 79",
  "ROSENBERG ESTEEM ITEM RESPONSE SCORE 87",
  "HGC 88",
  "TOT INC WAGES AND SALRY P-C YR 88",
  "TOT INC SP WAGE AND SALRY P-C YR 88",
  "TOT INC SP WAGE AND SALRY P-C YR 88 (TRUNC)",
  "TOT INC ALIMONY RCVD 87 88",
  "TOT INC CHILD SUPP RCVD 87 88",
  "AVG MO INC SSI RCVD IN 87 88",
  "TOT NET FAMILY INC P-C YR 88",
  "RS CURRENT RESIDENCE URBAN/RURAL 88",
  "RS CURRENT RESIDENCE IN SMSA 88",
  "HGC 90",
  "TOT NET FAMILY INC P-C YR 90",
  "RS CURRENT RESIDENCE URBAN/RURAL 90",
  "RS CURRENT RESIDENCE IN SMSA 90",
  "HGC 92",
  "20-ITEM CES-D ITEM RESPONSE SCORE 92",
  "TOT NET FAMILY INC P-C YR 92",
  "RS CURRENT RESIDENCE URBAN/RURAL 92",
  "RS CURRENT RESIDENCE IN SMSA 92",
  "HGHST GRADE/YR COMPLTD & GOT CREDIT 94",
  "TOTAL NET FAMILY INCOME 94",
  "RS RESIDENCE URBAN OR RURAL 94",
  "RS RESIDENCE IN SMSA 94",
  "TOTAL NET FAMILY INCOME 96",
  "RS RESIDENCE URBAN OR RURAL 96",
  "RS RESIDENCE IN SMSA 96",
  "HGHST GRADE/YR COMPLTD & GOT CREDIT 96",
  "HGHST GRADE/YR COMPLTD & GOT CREDIT 1998",
  "TOTAL NET FAMILY INCOME 1998",
  "RS RESIDENCE URBAN OR RURAL 1998",
  "RS RESIDENCE IN SMSA 1998",
  "HGHST GRADE/YR COMPLTD & GOT CREDIT 2000",
  "TOTAL NET FAMILY INCOME 2000",
  "RS RESIDENCE URBAN OR RURAL 2000",
  "RS RESIDENCE IN SMSA 2000"
)


# Use qnames rather than rnums

qnames = function(data) {
  names(data) <- c("VERSION_R26_2014",
    "CASEID_1979",
    "SAMPLE_ID_1979",
    "SAMPLE_RACE_78SCRN",
    "SAMPLE_SEX_1979",
    "ROSENBERG_IRT_SCORE_1987",
    "Q3-4_1988",
    "Q13-5_1988",
    "Q13-18_1988",
    "Q13-18_TRUNC_REVISED_1988",
    "INCOME-2C_1988",
    "INCOME-5D_1988",
    "INCOME-9C_1988",
    "TNFI_TRUNC_1988",
    "URBAN-RURAL_1988",
    "SMSARES_1988",
    "Q3-4_1990",
    "TNFI_TRUNC_1990",
    "URBAN-RURAL_1990",
    "SMSARES_1990",
    "Q3-4_1992",
    "CESD_IRT_SCORE_20_ITEM_1992",
    "TNFI_TRUNC_1992",
    "URBAN-RURAL_1992",
    "SMSARES_1992",
    "Q3-4_1994",
    "TNFI_TRUNC_1994",
    "URBAN-RURAL_1994",
    "SMSARES_1994",
    "TNFI_TRUNC_1996",
    "URBAN-RURAL_1996",
    "SMSARES_1996",
    "Q3-4_1996",
    "Q3-4_1998",
    "TNFI_TRUNC_1998",
    "URBAN-RURAL_1998",
    "SMSARES_1998",
    "Q3-4_2000",
    "TNFI_TRUNC_2000",
    "URBAN-RURAL_2000",
    "SMSARES_2000")
  return(data)
}


#********************************************************************************************************

# Remove the '#' before the following line to create a data file called "categories" with value labels.
categories <- vallabels(new_data)

# Remove the '#' before the following lines to rename variables using Qnames instead of Reference Numbers
#new_data <- qnames(new_data)
#categories <- qnames(categories)

# Produce summaries for the raw (uncategorized) data file
#summary(new_data)

# Remove the '#' before the following lines to produce summaries for the "categories" data file.
#categories <- vallabels(new_data)
#summary(categories)

#************************************************************************************************************

