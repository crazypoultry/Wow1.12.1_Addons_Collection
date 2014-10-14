//BankParser v3.1 part of
//GuildToolS package v3.1
//Parses the data saved by GTS_BankScan into html format
//  - Bank content
//
//Author: Roman Tarakanov (RTE/Arthas)
//Date: Aug 28 '06

#include <stdio.h>
#include <string.h>

struct banker {
  char name[20];
  int cash;
  char date[20];
};

int BankParser(int argc, char **argv){
  //temp variables
  int i, j, l=0, desc_len=0;
  char buf[10000], tmp[10], tmp2[10];
  char head[30000], tail[30000], link[100000];
  //pipes
  FILE *in, *out;
  //global variables
  int newowner=0, prevowner=0;
  //bank
  char num[100], sname[100], name[100], desc[10000], pic[100], type[100], id[10], subtype[100], owner[20];
  int quality, cost, numbankers = 0;
  struct banker bankers[100];
  //config variables
  char VER[7]="3.1";
  char TITLE[21]="My bank";
  long WIDTH=15;
  int PHP = 0;
  char SEARCHSITE[101]="http://www.thottbot.com/?s=";
  char IMAGESFOLDER[101]="images/";
  char STDIMAGESFOLDER[101]="images/";
  char IMAGEEXTENTION[11]=".jpg";
  char LUAFILE[101]="../SV/GTS_Core.lua";
  char OUTPUT[101]="../html/bank.html";

  head[0]= '\0';
  tail[0]= '\0';
  link[0]= '\0';
  
  //Slash handler
  for (i=1; i<argc; i++)
  {
    if (strcmp(argv[i],"-t")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>20) argv[i+1][20]=0;
      strncpy(TITLE, argv[i+1], strlen(argv[i+1]));
      TITLE[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-w")==0 && i<argc-1)
    {
      WIDTH=strtol(argv[i+1], NULL, 10);
      if (WIDTH<6) WIDTH=6;
      if (WIDTH>22) WIDTH=22;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-s")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(SEARCHSITE, argv[i+1], strlen(argv[i+1]));
      SEARCHSITE[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-sif")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(STDIMAGESFOLDER, argv[i+1], strlen(argv[i+1]));
      STDIMAGESFOLDER[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-if")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(IMAGESFOLDER, argv[i+1], strlen(argv[i+1]));
      IMAGESFOLDER[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-ie")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>10) argv[i+1][10]=0;
      strncpy(IMAGEEXTENTION, argv[i+1], strlen(argv[i+1]));
      IMAGEEXTENTION[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-i")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(LUAFILE, argv[i+1], strlen(argv[i+1]));
      LUAFILE[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-o")==0 && i<argc-1)
    {
      if (strlen(argv[i+1])>100) argv[i+1][100]=0;
      strncpy(OUTPUT, argv[i+1], strlen(argv[i+1]));
      OUTPUT[strlen(argv[i+1])]=0;
      i++;
      continue;
    }
    if (strcmp(argv[i],"-php")==0)
    {
      PHP = 1;
      continue;
    }
    if (strcmp(argv[i],"-?")==0 || strcmp(argv[i],"-help")==0)
    {
      printf("\nBankParser v%s \nParses the data saved in SavedVariables.lua by GTS_BankScan into html format.\n\n", VER);
      printf("Any of the flags can be used in any order.\n");
      printf("If flag is used more than once in one statement last inputed value will be used\n");
      printf("'\"' character cannot be used in strings.\n");
      printf("If your string has spaces in it put it in \" \" Ex: '-t \"My bank\"'.\n");
      printf("\"\" sharacters are not necessary around a string statement if your string does\n");
      printf(" not contain spaces.\n\n");
      printf("Advanced mode flags:\n\n");
      printf("-t <string>    - Title. Set the title of the page to the string passed.\n");
      printf("                 Ex: '-t \"Guild Bank\"'.\n");
      printf("                 Default: '%s'.\n",TITLE);
      printf("                 Max string length is 20 chars.\n");
      printf("-w <number>    - Width. Set the number of items in the backpack in one row.\n");
      printf("                 Ex: '-w 12'.\n");
      printf("                 Default: %d.\n",WIDTH);
      printf("                 Available range: 6-22.\n");
      printf("-s <string>    - Searchsite. Sets the site that will be linked upon the click\n");
      printf("                  on the item. Resulting link will be: <string><name of the\n");
      printf("                  item '+' separated>.\n");
      printf("                 Ex: '-s http://www.mysite.com/?s='.\n");
      printf("                 Default: '%s'.\n",SEARCHSITE);
      printf("                 Max string length is 100 chars.\n");
      printf("-if <string>   - Images foulder. Sets the folder where the images will be\n");
      printf("                  taken from.\n");
      printf("                 Ex: '-if http://www.somesite.com/images/'.\n");
      printf("                 Default: '%s'.\n",IMAGESFOLDER);
      printf("                 Max string length is 100 chars.\n");
      printf("-sif <string>  - Standart Images foulder. Sets the folder where the built-in\n");
      printf("                  images will be taken from. (those .gif that are supplied)\n");
      printf("                 Ex: '-if http://www.somesite.com/images/'.\n");
      printf("                 Default: '%s'.\n",STDIMAGESFOLDER);
      printf("                 Max string length is 100 chars.\n");
      printf("-ie <string>   - Images extention. Sets the images extention.\n");
      printf("                 Ex: '-ie .jpg'.\n");
      printf("                 Default: '%s'.\n",IMAGEEXTENTION);
      printf("                 Max string length is 10 chars.\n");
      printf("-i <string>    - Input. Path to the input file (SavedVariables.lua).\n");
      printf("                 Ex: '-i \"../../WTF/Account/MyAccount/SavedVariables.lua\"'.\n");
      printf("                 Default: '%s'.\n",LUAFILE);
      printf("                 Max string length is 100 chars.\n");
      printf("-o <string>    - Output. Path to output file.\n");
      printf("                 Ex: '-o c:/mywebpage/guildbank.html'.\n");
      printf("                 Default: '%s'.\n",OUTPUT);
      printf("                 Max string length is 100 chars.\n");
      printf("-php           - generates only tables to the output file.\n");
      printf("\nCall Ex: 'GTS -bank -t \"Guild Bank\" -o ./bank.thml -w 17 -ie \".jpg\"'.\n");
      return 0;
    }
    printf("Improper use of arguments: check help (-?) for proper arguments list.\n");
    return 1;
  }
  
  printf("\nBankParser v%s \nParses the data saved in SavedVariables.lua by GTS_BankScan into html format.\n\n", VER);

  if (argc>1)
  {
    printf("   ******    Advanced mode.   *******\n\n");
    printf("Title:                    '%s'\n",TITLE);
    printf("Number of items per row:  '%d'\n",WIDTH);
    printf("Link to the searchsite:   '%s<item name>'\n",SEARCHSITE);
    printf("Link to image:            '%s<name>%s'\n",IMAGESFOLDER,IMAGEEXTENTION);
    printf("Location of input file:   '%s'\n",LUAFILE);
    printf("Output output html file:  '%s'\n\n",OUTPUT);
    printf("   **********************************\n\n");
  }
  
  //Open SavedVariables.lua file for reading
  printf("Opening SV.lua file for read ... ");
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  
  //Create and open bank.html for write
  printf("Opening %s file for write ... ", OUTPUT);
  if ((out=fopen(OUTPUT,"wt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not create output file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not create output file (%s). Make sure you have permision to create files.\n", OUTPUT);
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Make sure there is data in file
  printf("Checking for data availability (GTS_Data) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"GTS_Data",9)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"GTS_Data",9) != 0)
  {
    printf("Failed.\n   Reson: Necessaryata was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  printf("Checking for data entry (BS) ... ");
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"BS\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"BS\"]",4) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"Money\"]",9)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (Money) ... ");
  if (strncmp(buf,"[\"Money\"]",9) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Reads the money in posession of bank characters
  if (strncmp(buf,"[\"Money\"]",10)==0) 
  {
    while (strncmp(buf,"{",1)!=0) fscanf(in,"%s",buf);
    fscanf(in,"%s",buf);
    while (strncmp(buf, "},", 2)!=0)
    {
      char name[20];
      int cash;
      //Read the cash of the char
      fscanf(in, " = \" %d \",", &cash);
      //Read the name of bank char
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        strncpy(name, buf+2, strlen(buf)-4);
        name[strlen(buf)-4] = '\0';
      }
      for (i=0; i<numbankers; i++)
      {
        if (strcmp(name, bankers[i].name) == 0)
        {
          bankers[i].cash = cash;
          break;
        }
      }
      if (strcmp(name, bankers[i].name) != 0)
      {
        bankers[numbankers].cash = cash; 
        strcpy(bankers[numbankers].name, name);  
        numbankers++;            
      }
      fscanf(in, "%s", buf);
    }
  }
  fclose(in);
  
  //Open SavedVariables.lua file for reading
  printf("Reopening SV.lua file for read ... ");
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
     
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"BS\"]",6)!=0)) ;
  //If variables are not found - halt
  if (strncmp(buf,"[\"BS\"]",4) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"Date\"]",9)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (Date) ... ");
  if (strncmp(buf,"[\"Date\"]",9) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  //Reads the date scanned for all bank characters
  if (strncmp(buf,"[\"Date\"]",13)==0) 
  {
    while (strncmp(buf,"{",1)!=0) fscanf(in,"%s",buf);
    fscanf(in,"%s",buf);
    while (strncmp(buf, "},", 2)!=0)
    {
      char name[20],date[20];
      //Read the date of last parse
      fscanf(in, " = \" %s \",", date);
      //Read the name of bank char
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        strncpy(name, buf+2, strlen(buf)-4);
        name[strlen(buf)-4] = '\0';
      }
      for (i=0; i<numbankers; i++)
      {
        if (strcmp(name, bankers[i].name) == 0)
        {
          strcpy(bankers[i].date, date);
          break;
        }
      }
      if (strcmp(name, bankers[i].name) != 0)
      {
        strcpy(bankers[numbankers].date, date);
        strcpy(bankers[numbankers].name, name);   
        numbankers++;            
      }
      fscanf(in, "%s", buf);
    }  
  }
         
  fclose(in);
  
  //Open SavedVariables.lua file for reading
  printf("Reopening SV.lua file for read ... ");
  if ((in=fopen(LUAFILE,"rt")) == NULL)
  {
    if (argc>1) printf("Failed.\n   Reson: Could not find input file. Make sure that you specified proper file.\n");
    else printf("Failed.\n   Reson: Could not find input file. Make sure that you copied SavedVaribles.lua to the AddOn folder.\n");
    return 1;
  }else printf("Ok.\n");
  
  while ((fscanf(in, "%s", buf)!=EOF) && (strncmp(buf,"[\"ScannedItems\"]",17)!=0)) ;
  //If variables are not found - halt
  printf("Checking for data availability (ScannedItems) ... ");
  if (strncmp(buf,"[\"ScannedItems\"]",17) != 0)
  {
    printf("Failed.\n   Reson: Necessary data was not found in SavedVariables.lua.\n");
    printf("          Make sure you run GTS_BankScan script first.\n");
    fclose(in);
    return 1;
  }else printf("Ok.\n");
  
  strcat(head,"<html>\n\n<head>\n");
  strcat(head,"<meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">\n");
  strcat(head,"<script language=\"JavaScript\">\n<!--\nns4 = document.layers\n");
  strcat(head,"ie4 = document.all\nnn6 = document.getElementById && !document.all\n");
  strcat(head,"function hideObject(id) {\n   if (ns4) {\n      document.id.visibility = \"hide\";\n");
  strcat(head,"   }   else if (ie4) {\n      document.all[id].style.visibility = \"hidden\";\n");
  strcat(head,"   }   else if (nn6) {\n      document.getElementById(id).style.visibility = \"hidden\";\n");
  strcat(head," }\n}\nfunction showObject(id) {\n   if (ns4) {\n      document.id.visibility = \"show\";\n");
  strcat(head,"   }   else if (ie4) {\n      document.all[id].style.visibility = \"visible\";\n");
  strcat(head,"   }   else if (nn6) {\n      document.getElementById(id).style.visibility = \"visible\";\n");
  strcat(head,"   }\n}\n//-->\n</script>\n<title>");
  strcat(head,TITLE);
  strcat(head,"</title>\n</head>\n\n<body lang=EN-US>\n");
  
  strcat(tail,"	  </td>\n	 </tr>\n	</table>\n       </td>\n");
  strcat(tail,"       <td width=22 valign=top background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp022.gif\">\n");
  strcat(tail,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
  strcat(tail,"    <td width=");
  sprintf(tmp,"%d",WIDTH*44+38);
  strcat(tail,tmp);
  strcat(tail," height=10 valign=top>\n");
  strcat(tail,"     <table width=");
  strcat(tail,tmp);
  strcat(tail," border=0 cellspacing=0 cellpadding=0>\n      <tr>\n");
  strcat(tail,"       <td width=55 height=10 valign=top valign=top align=center background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp030.gif\">\n       </td>\n");
  strcat(tail,"       <td width=");
  sprintf(tmp,"%d",WIDTH*44+38-55-50);
  strcat(tail,tmp);
  strcat(tail," height=10 valign=top align=center background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp031.gif\">\n       </td>\n");
  strcat(tail,"       <td width=50 height=10 valign=top valign=top align=center ");
  strcat(tail,"background = \"");
  strcat(tail, STDIMAGESFOLDER);
  strcat(tail, "bp032.gif\">\n");
  strcat(tail,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n");
  strcat(tail,"  </table>\n");
  if (PHP == 0)
  {
    strcat(tail,"<p>\n<span style=\"font-size: 12px; color: #5F5F5F;\">This page was generated by ");
    strcat(tail,"<a href=\"http://www.curse-gaming.com/mod.php?addid=1899\">");
    strcat(tail,"(GTS)GuildBank v");
    strcat(tail, VER);
    strcat(tail,"</a>.</span>\n</body>\n\n</html>");
  }

  if (PHP == 0) fprintf(out, head);
  
  //Read the bank items
  if (strncmp(buf,"[\"ScannedItems\"]",17)==0) 
  {
    fscanf(in, "%s", buf);
    while (strncmp(buf, "}", 1)!=0)
    {
      if (strstr(buf,"[\"")==NULL || strstr(buf,"\"]")==NULL) 
        fscanf(in, "%s", buf);
      if (strstr(buf,"[\"")!=NULL && strstr(buf,"\"]")!=NULL)
      {
        //Read the name of bank char
        strncpy(owner, buf+2, strlen(buf)-4);
        owner[strlen(buf)-4] = '\0';
        newowner=1;
        fscanf(in, " = { %s", buf);
        
        //Reset all the starage vars for item info before scanning
        quality=0;
        cost = 0;
        l = 1;
        name[0]='\0';
        sname[0]='\0';
        num[0]='\0';
        pic[0]='\0';
        desc[0]='\0';
        link[0]='\0';
        id[0] = '\0';
        type[0]='\0';
        subtype[0]='\0';
        
        //Scan item's info
        while (strncmp(buf, "},", 2)!=0)
        {
          //Clear old data for this bunk char in DB
          if (newowner==1)
          {
            newowner=0;
            int money;
            char date[20];
            date[0] = '\0';
            link[0]='\0';
            for (i=0; i<numbankers; i++)
            {
              if (strncmp(bankers[i].name, owner, strlen(owner)) == 0)
              {
                money = bankers[i].cash;
                sprintf(date, "20%s", bankers[i].date);                             
              }    
            }
            if (prevowner == 1)
            {
              strcat(link,"	  </td>\n	 </tr>\n	</table>\n       </td>\n");
              strcat(link,"       <td width=22 valign=top background = \"");
              strcat(link, STDIMAGESFOLDER);
              strcat(link, "bp022.gif\">\n");
              strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
              strcat(link,"    <td width=");
              sprintf(tmp,"%d",WIDTH*44+38);
              strcat(link,tmp);
              strcat(link," height=10 valign=top>\n");
              strcat(link,"     <table width=");
              strcat(link,tmp);
              strcat(link," border=0 cellspacing=0 cellpadding=0>\n      <tr>\n");
              strcat(link,"       <td width=55 height=10 valign=top valign=top align=center background = \"");
              strcat(link, STDIMAGESFOLDER);
              strcat(link, "bp030.gif\">\n       </td>\n");
              strcat(link,"       <td width=");
              sprintf(tmp,"%d",WIDTH*44+38-55-50);
              strcat(link,tmp);
              strcat(link," height=10 valign=top align=center background = \"");
              strcat(link, STDIMAGESFOLDER);
              strcat(link, "bp031.gif\">\n       </td>\n");
              strcat(link,"       <td width=50 height=10 valign=top valign=top align=center ");
              strcat(link,"background = \"");
              strcat(link, STDIMAGESFOLDER);
              strcat(link, "bp032.gif\">\n");
              strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n");
              strcat(link,"  </table>\n"); 
              strcat(link,"<!--               NEXT           -->\n");              
            }
            strcat(link,"  <table width=");
            sprintf(tmp,"%d",WIDTH*44+38);
            sprintf(tmp2, "%d",WIDTH*44+38-150);
            strcat(link,tmp);
            strcat(link," border=0 cellspacing=0 cellpadding=0>\n   <tr>\n");
            strcat(link,"    <td width=");
            strcat(link,tmp);
            strcat(link," height=48 valign=top>\n");
            strcat(link,"     <table width=");
            strcat(link,tmp);
            strcat(link," border=0 cellspacing=0 cellpadding=0>\n");
            strcat(link,"      <tr>\n       <td width=55 height=48 valign=top valign=top ");
            strcat(link,"align=center background = \"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link,"bp010.gif\">\n       </td>\n");
            strcat(link,"       <td width=");      
            sprintf(tmp, "%d",WIDTH*44+38-55-50);
            strcat(link, tmp);
            strcat(link," height=48 valign=top align=center background = \"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link,"bp011.gif\">\n");
            strcat(link,"	<table width=* height=48 border=0 cellspacing=0 cellpadding=0>\n");
            strcat(link,"	 <tr height=26>\n");
            strcat(link,"	  <td width=");
            strcat(link, tmp);
            strcat(link," valign=bottom align=center>\n");
            strcat(link,"	   <p><span style='color:white'>");
            strcat(link,owner);
            strcat(link,"</span></p>\n");
            strcat(link,"	  </td>\n	 </tr>\n");
            strcat(link,"	 <tr height=22>\n");
            strcat(link,"	  <td width=\"200\" valign=bottom align=left>\n");
            strcat(link,"	   <p><span style='color:white'>");
            strcat(link, date);
            strcat(link,"</span></p>\n");
            strcat(link,"	  </td>\n");
            strcat(link,"	  <td width=");
            strcat(link, tmp2);
            strcat(link," valign=bottom align=right>\n");
            strcat(link,"	   <p><span style='color:white'>");
            sprintf(tmp,"%d",money/10000);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "gold.gif\">");
            sprintf(tmp,"%d",(money/100)%100);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "silver.gif\">");
            sprintf(tmp,"%d",money%100);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "copper.gif\">");
            strcat(link,"</span></p>\n");
            strcat(link,"	  </td>\n	 </tr>\n");
            strcat(link,"	</table>\n       </td>\n");
            strcat(link,"       <td width=50 height=48 valign=top align=center ");
            strcat(link,"background = \"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "bp012.gif\">\n");
            strcat(link,"       </td>\n      </tr>\n     </table>\n    </td>\n   </tr>\n   <tr>\n");
            strcat(link,"    <td width=");
            sprintf(tmp,"%d",WIDTH*44+38);
            strcat(link,tmp);
            strcat(link," valign=top>\n     <table border=0 cellspacing=0 cellpadding=0>\n");
            strcat(link,"      <tr>\n       <td width=16 valign=top background = \"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "bp020.gif\">\n");
            strcat(link,"       </td>\n       <td width=");
            sprintf(tmp,"%d",WIDTH*44+38-16-22);
            strcat(link, tmp);
            strcat(link," valign=top background = \"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "bp021.gif\">\n");
            strcat(link,"	<table width=* border=0 cellspacing=0 cellpadding=0>\n	 <tr>\n");
            prevowner = 1; 
            fprintf(out, link);
            link[0]='\0';
          }
                 
          //Actual item's scan
          //Quantity
          if (strncmp(buf, "[\"number\"]", 10)==0)
          {    
            fscanf(in, " = \" %s \",", buf);
            strncpy(num, buf, strlen(buf)+1);
          }
          //Price
          if (strncmp(buf, "[\"price\"]", 9)==0)
          {            
            fscanf(in, " = \" %d \",", &cost);
          }
          //Item ID
          if (strncmp(buf, "[\"id\"]", 10)==0)
          {
            fscanf(in, " = \" %s \",", buf);
            strncpy(id, buf, strlen(buf)+1);
          }
          //Quality
          if (strncmp(buf, "[\"quality\"]", 11)==0)
          {
            fscanf(in, " = \" %d \",", &quality);
          }
          //Icon
          if (strncmp(buf, "[\"pic\"]", 7)==0)
          {
            fscanf(in, " = \" %s \",", buf);
            strncpy(pic, buf, strlen(buf)+1);
          }
          //Type
          if (strncmp(buf, "[\"type\"]", 10)==0)
          {
            fscanf(in, " = \" %s", buf);
            while (strncmp(buf, "\",", 2)!=0)
            {
              if (type[0]!='\0')
              {
                strncat(type, " ", 1);
              }
              strncat(type, buf, strlen(buf)+1);
              fscanf(in, "%s", buf);
            }
          }
          //Subtype
          if (strncmp(buf, "[\"subtype\"]", 10)==0)
          {
            fscanf(in, " = \" %s", buf);
            while (strncmp(buf, "\",", 2)!=0)
            {
              if (subtype[0]!='\0')
              {
                strncat(subtype, " ", 1);
              }
              strncat(subtype, buf, strlen(buf)+1);
              fscanf(in, "%s", buf);
            }
          }
          //Name
          if (strncmp(buf, "[\"name\"]", 8)==0)
          {
            fscanf(in, " = \" %s", buf);
	        while (strncmp(buf, "\",", 2)!=0)
	        {
	          if (sname[0]!='\0')
	          {
	            strncat(sname, "+", 1);
	            strncat(name, " ", 1);
              }
	          strncat(sname, buf, strlen(buf)+1);
	          strncat(name, buf, strlen(buf)+1);
	          fscanf(in, "%s", buf);
            }
            //fprintf(stderr, "\nName: %s", name);
          }
          //Description
          if (strncmp(buf, "[\"description\"]", 15)==0)
      	  {
  	        fscanf(in, " = \" %s", buf);
       	    while (strncmp(buf, "<n>", 3)!=0 && strncmp(buf, "\",", 2)!=0)
       	    {
      	      fscanf(in, "%s", buf);
       	    }
       	    while (strncmp(buf, "\",", 2)!=0)
       	    {
      	      if (strncmp(buf, "<n>", 3)==0)
       	      {
      	        strncat(desc, "<br>", 5);
       	        desc_len=0;
       	      }
       	      else if (strncmp(buf, "<t>", 3)==0)
       	      {
      	        for (i = desc_len; i<40; i++)
  		          strncat(desc, "&nbsp;", 7);
      	        strncat(desc, "\0", 1);
       	      }
       	      else if (strncmp(buf, "<c>", 3)==0)
       	      {
      	        strcat(desc, "</span><span style=\"font-size: 12px;color:#");
                fscanf(in, "%s", buf);
                strcat(desc, buf);
                strcat(desc, ";\">");
      	        strncat(desc, "\0", 1);
       	      }
       	      else
       	      {
      	        strncat(desc, " ", 1);
       	        strncat(desc, buf, strlen(buf)+1);
       	        desc_len+=strlen(buf)+1;
       	      }
       	      fscanf(in, "%s", buf);
       	    }
   	      } 
          //End of variables list
          
          fscanf(in, "%s", buf);
          //If all the variables have been scanned for this item - 
          //add it to the html file
          if (strncmp(buf, "},", 2)==0 && name[0]!='\0')
          {
          
            //Removes esc chars infront of every " char in name
            buf[0]='\0';
            strcpy(buf, name);
            name[0]='\0';
            while(strchr(buf,'\\')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\\'));
              len = strlen(buf);
              char a[100];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(name, a);
              strncpy(buf, buf+pos+1, len-pos);                   
            }
            strcat(name, buf);
            //Removes esc chars infront of every " char in description
            strcpy(buf, desc);
            desc[0]='\0';
            while(strchr(buf,'\\')!=NULL)
            {
              int pos,len;
              pos = strlen(buf)-strlen(strchr(buf,'\\'));
              len = strlen(buf);
              char a[1000];
              a[0]='\0';
              strncpy(a,buf,pos);
              a[pos]='\0';
              strcat(desc, a);
              strncpy(buf, buf+pos+1, len-pos);                    
            }
            strcat(desc, buf);
            
            strcat(link,"          <td width=44 height=44 valign=middle align=center>\n");
            strcat(link,"           <a onClick=javascript:window.open(\"");
            strcat(link, SEARCHSITE);
            strcat(link, sname);
            strcat(link,"\",\"blank\",\"\"); style=\"text-decoration: none\" onMouseOver=");
            strcat(link,"\"javascript:showObject('");
            sprintf(tmp,"%s%d",owner,l);
            strcat(link, tmp);
            strcat(link,"');\" onMouseOut=\"javascript:hideObject('");
            strcat(link, tmp);
            strcat(link,"');\">");
            strcat(link,"<span style=\"position:absolute; cursor:hand;\"><table width=36 height=40 ");
            strcat(link,"cellpadding=0 cellspacing=0 border=0><tr><td valign=bottom ");
            strcat(link,"align=right><span style=\"font-size: 12px;color: white; font-weight:bold;\">");
            if (strncmp(num, "1", 2)!=0) strcat(link, num);
            strcat(link,"</span></td></tr></table></span><img src=\"");
            strcat(link, IMAGESFOLDER);
            strcat(link, pic);
            strcat(link, IMAGEEXTENTION);
            strcat(link,"\" width=40 height=40 border=0");
            strcat(link," style=\"margin-right: 0px; border: 0px\"\"></a>\n");
            strcat(link,"<div id=\"");
            strcat(link,tmp);
            strcat(link,"\" style=\"position:absolute; z-index:1; visibility:hidden;\">");
            strcat(link,"<table width=200 border=0 cellpadding=0 cellspacing=0>");
            strcat(link,"<tr><td><img src=");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "top.gif></td></tr><tr>");
            strcat(link,"<td><table width=200 border=0 cellspacing=0 ");
            strcat(link,"cellpadding=0><tr><td width=19 background=");
            strcat(link, STDIMAGESFOLDER);
            strcat(link,"left.jpg>&nbsp;</td><td  bgcolor=#303030  valign=top>");
            strcat(link,"<table bgcolor=\"#303030\" width=100%% cellpadding=3 ");
            strcat(link,"cellspacing=0 border=0 valign=top align=left><tr><td>");
            strcat(link,"<span style=\"font-size: 12px;");
            
            if (quality==0) strcat(link,"color:#9D9D9D;\"><b>");
            if (quality==1) strcat(link,"color:#FFFFFF;\"><b>");
            if (quality==2) strcat(link,"color:#1EFF00;\"><b>");
            if (quality==3) strcat(link,"color:#0070DD;\"><b>");
            if (quality==4) strcat(link,"color:#A335EE;\"><b>");
            if (quality==5) strcat(link,"color:#EE9900;\"><b>");
            strcat(link, name);
            strcat(link,"</b></span><span style=\"font-size: 12px; color:white\">");
            strcat(link, desc);
            strcat(link, "</span><br><br><span style=\"font-size: 12px;color:#FFFFFF;\">");
            sprintf(tmp,"%d",cost/10000);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "gold.gif\">");
            sprintf(tmp,"%d",(cost/100)%100);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "silver.gif\">");
            sprintf(tmp,"%d",cost%100);
            strcat(link, tmp);
            strcat(link,"<img src=\"");
            strcat(link, STDIMAGESFOLDER);
            strcat(link, "copper.gif\">");
            strcat(link,"</span></td></tr></table></td><td width=19 background=");
            strcat(link, STDIMAGESFOLDER);
            strcat(link,"right.jpg>&nbsp;</td></tr></table></td></tr><tr><td>");
            strcat(link,"<img src=");
            strcat(link, STDIMAGESFOLDER);
            strcat(link,"bot.jpg width=200 height=19></td></tr></table>");
            strcat(link,"</div></td>");
            if ((l%WIDTH)==0) strcat(link,"</tr>\n");
            else strcat(link,"\n");
            //Put link into output file
            fprintf(out, link);
            
            //reset store variables for the next scan
            quality=0;
            cost = 0;
            name[0]='\0';
            sname[0]='\0';
            num[0]='\0';
            pic[0]='\0';
            desc[0]='\0';
            id[0] = '\0';
            type[0]='\0';
            subtype[0]='\0';
            link[0]='\0';
            l++;
            
            fscanf(in, "%s", buf);
          }
        }
      }
      fscanf(in, "%s", buf);
    }
  }
  
  fprintf(out, tail);
  fclose(in);
  fclose(out);
  return 0;
}
