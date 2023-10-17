//+------------------------------------------------------------------+
//|                                                        Panel.mq5 |
//|                               Copyright 2023, Krzysztof Kamiński |
//|                                       https://www.QuantTrader.pl |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Krzysztof Kamiński"
#property link      "https://www.QuantTrader.pl"
#property version   "1.00"
#include <Functions.mqh>
//global variables
bool Long = false;
double TradeVolume=0.01;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CWindow : public CAppDialog
  {
private:
   CButton           button;
   CButton           button2;
   CButton           button3;
   CEdit             object;

public:
                     CWindow(void);
                    ~CWindow(void);

   virtual bool      Create(
      const long    chart,      // chart ID
      const string  name,       // name
      const int     subwin,     // chart subwindow
      const int     x1,         // coordinate
      const int     y1,         // coordinate
      const int     x2,         // coordinate
      const int     y2          // coordinate
   );

   virtual bool      OnEvent(
      const int      id,         // ID
      const long&    lparam,     // parameter
      const double&  dparam,     // parameter
      const string&  sparam      // parameter
   );
protected:
   bool              CreateButton();
   bool              CreateButton2();
   bool              CreateButton3();
   bool              CreateObject();
   void              OnClickButton();
   void              OnClickButton2();
   void              OnClickButton3();
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CWindow::CWindow(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CWindow::~CWindow(void)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CWindow::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1, y1, x2,y2))
      return (false);
   if(!CreateButton())
      return (false);
   if(!CreateButton2())
      return (false);
   if(!CreateButton3())
      return (false);
   if(!CreateObject())
      return (false);
   return (true);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CWindow)
ON_EVENT(ON_CLICK,button, OnClickButton)
ON_EVENT(ON_CLICK,button2, OnClickButton2)
ON_EVENT(ON_CLICK,button3, OnClickButton3)
EVENT_MAP_END(CAppDialog)

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CWindow::CreateButton(void)
  {
   int x1 = 180;
   int y1= 60;
   int x2 = x1+100;
   int y2 = y1+30;

   if(!button.Create(0,"Button",0,x1,y1,x2,y2))
      return (false);
   if(!button.Text("BUY"))
      return(false);
   if(!button.Color(clrWhite))
      return (false);
   if(!button.ColorBackground(clrBlue))
      return(false);
   if(!Add(button))
      return (false);

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CWindow::CreateButton2(void)
  {
   int x1 = 60;
   int y1= 60;
   int x2 = x1+100;
   int y2 = y1+30;

   if(!button2.Create(0,"Button2",0,x1,y1,x2,y2))
      return (false);
   if(!button2.Text("SELL"))
      return(false);
   if(!button2.Color(clrWhite))
      return (false);
   if(!button2.ColorBackground(clrRed))
      return(false);
   if(!Add(button2))
      return (false);

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CWindow::CreateButton3(void)
  {
   int x1 = 120;
   int y1= 100;
   int x2 = x1+100;
   int y2 = y1+30;

   if(!button3.Create(0,"Button3",0,x1,y1,x2,y2))
      return (false);
   if(!button3.Text("CLOSE"))
      return(false);
   if(!button3.Color(clrWhite))
      return (false);
   if(!button3.ColorBackground(clrDarkRed))
      return(false);
   if(!Add(button3))
      return (false);

   return (true);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CWindow::CreateObject(void)
  {
   int x1 = 155;
   int y1= 25;
   int x2 = x1+35;
   int y2 = y1+30;

   if(!object.Create(0,"Object",0,x1,y1,x2,y2))
      return (false);
   if(!object.Text(string(0.1)))
      return (false);
   if(!Add(object))
      return (false);
   return (true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CWindow::OnClickButton(void)
  {
   Long = true;
   double ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   trade.Buy(TradeVolume,_Symbol,ask);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CWindow::OnClickButton2(void)
  {
   Long = false;
   double bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   trade.Sell(TradeVolume,_Symbol,bid);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CWindow::OnClickButton3(void)
  {
   CloseAll();
  }
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
CWindow Dialog;
int OnInit()
  {
//---
   if(!Dialog.Create(0,"Dialog",0,40,40,380,350))
      return (INIT_FAILED);
//---
   Dialog.Run();
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   Dialog.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   if(sparam=="Object")
     {
      string volumeText = ObjectGetString(0,"Object",OBJPROP_TEXT);
      double ratioPer = StringToDouble(volumeText);
      TradeVolume = OpenForPer(ratioPer,Long);
      return;
     }
   Dialog.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
