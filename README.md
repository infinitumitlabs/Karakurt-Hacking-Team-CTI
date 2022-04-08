# Karakurt Hacking Team Indicators of Compromise (IOC)

These IOCs were released as part of CTI team research by Infinitum IT. The full report is available [here](https://www.infinitumit.com.tr/en/conti-ransomware-group-behind-the-karakurt-hacking-team/)

One of the most valuable pieces of threat intelligence we discovered during this CTI investigation was the the IP address of the Karakurt / Conti data storage and Command and Control Servers.

| Domain                      |     IP          |
| --------------------------- | ----------------|
| karakurt.co                 |  209.222.98.19  |
| stok-061153.stokermate.com  |  104.238.61.153 |

Real IP Address of Onion site used by Karakurt Hacking Team as a public leak page

| Onion site                                                      |    IP          |
| ----------------------------------------------------------------| ----------------|
| lhxxtrqraokn63f3nubhbjrzxkrgduq3qogp3yr424tkpvh3z7n4kcyd.onion  | 104.243.34.214 |

## Karakurt Leak Site

![Data_Karakurt](https://user-images.githubusercontent.com/46815608/162378797-0413c443-ae28-4fee-a6f3-87c8a4a3a986.PNG)


Following table contains the authentication logs of the subject Karakurt servers with IP **209.222.98.19** and **104.238.61.153**

| Detected TCP Connections on Karakurt Servers |
| ---------------------------------------------|
| 45.8.119.60                                  |
| 212.220.115.145                              |
| 5.45.83.32                                   |
| 31.14.40.64                                  |
| 95.170.133.54                                |
| 1.116.139.11                                 |
| 45.141.84.126                                |
| 185.5.251.35                                 |
| 49.232.93.149                                |                               
| 61.177.173.17
| 80.93.19.227
| 139.219.4.103
| 61.19.125.2
| 159.65.140.76
| 23.99.177.202
| 109.169.14.109
| 104.243.34.214
| 37.252.0.143
| 46.166.143.114 

Durring our CTI research on Karakurt / Conti Servers we are able to identify the use of SOCKS proxy pivoting technique with a open source tool called [Ligolo-ng](https://github.com/tnpitsecurity/ligolo-ng) against multiple victims.

Following table contains the Ligolo-ng Agent and Command and Control Server used by Karakurt Hacking Team Members

| Ligolo-ng Agent and Command and Control Servers |
| ------------------------------------------------|
| 104.194.9.238/download/lig.ext                   
| 104.194.9.238:455/download/lig2.ext
| 104.238.61.153


