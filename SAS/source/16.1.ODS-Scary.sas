proc template;
define statgraph Base.Corr.Graphics.MatrixPlot;
   notes "Scatter Plot Matrix";
   dynamic _Title _SymMatrix _Histogram _DesignHeight _DesignWidth _byline_ _bytitle_ _byfootnote_;
   BeginGraph / designheight=_DesignHeight designwidth=_DesignWidth;
      EntryTitle _TITLE;
      Layout Gridded;
         if (_SYMMATRIX)
            if (_HISTOGRAM)
               ScatterPlotMatrix VVAR1 VVAR2 VVAR3 VVAR4 VVAR5 VVAR6 VVAR7 VVAR8 VVAR9 VVAR10 / rolename=(_tip1=_OBSNUM _id1=_ID1
                  _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x _tip1 _id1 _id2 _id3 _id4 _id5) start=topleft diagonal=(
                  histogram);
            else
               ScatterPlotMatrix VVAR1 VVAR2 VVAR3 VVAR4 VVAR5 VVAR6 VVAR7 VVAR8 VVAR9 VVAR10 / rolename=(_tip1=_OBSNUM _id1=_ID1
                  _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x _tip1 _id1 _id2 _id3 _id4 _id5) start=topleft;
            endif;
         else
            ScatterPlotMatrix VVAR1 VVAR2 VVAR3 VVAR4 VVAR5 VVAR6 VVAR7 VVAR8 VVAR9 VVAR10 / RowVars=(WVAR1 WVAR2 WVAR3 WVAR4 WVAR5
               WVAR6 WVAR7 WVAR8 WVAR9 WVAR10) rolename=(_tip1=_OBSNUM _id1=_ID1 _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x
               _tip1 _id1 _id2 _id3 _id4 _id5) start=topleft;
         endif;
      EndLayout;
      if (_BYTITLE_)
         entrytitle _BYLINE_ / textattrs=GRAPHVALUETEXT;
      else
         if (_BYFOOTNOTE_)
            entryfootnote halign=left _BYLINE_;
         endif;
      endif;
   EndGraph;
end;

define statgraph Base.Corr.Graphics.ScatterPlot;
   notes "Scatter Plot";
   dynamic _Title _Title1 _YName _XName _Ellipse _Ellipse1 _Ellipse2 _LegendTitle _Inset _InsetLoc _Nobs _Corr _byline_ _bytitle_
      _byfootnote_;
   BeginGraph;
      EntryTitle _TITLE;
      if (_ELLIPSE1)
         EntryTitle textattrs=GRAPHVALUETEXT _TITLE1;
      endif;
      Layout Overlay / XAxisopts=(display=all ShortLabel=_XNAME) YAxisopts=(display=all ShortLabel=_YNAME);
         if (_ELLIPSE)
            EllipseParm semimajor=_MAJOR semiminor=_MINOR slope=_SLOPE xorigin=_XMEAN yorigin=_YMEAN / name="ellipse" clip=true
               group=_LEVEL name="ConfLevel" legendlabel='Ellipse Confidence Levels';
         endif;
         ScatterPlot y=WVAR x=VVAR / rolename=(_tip1=_OBSNUM _id1=_ID1 _id2=_ID2 _id3=_ID3 _id4=_ID4 _id5=_ID5) tip=(y x _tip1 _id1
            _id2 _id3 _id4 _id5);
         if (_INSET)
            layout gridded / columns=2 halign=left valign=_INSETLOC border=true;
               entry halign=left "Observations" / valign=top;
               entry halign=right eval (PUT(_NOBS,BEST6.)) / valign=top;
               entry halign=left "Correlation" / valign=top;
               entry halign=right eval (PUT(_CORR,BEST6.)) / valign=top;
            endlayout;
         endif;
         if (_ELLIPSE2)
            DiscreteLegend "ConfLevel" / title=_LEGENDTITLE halign=center valign=bottom;
         endif;
      EndLayout;
      if (_BYTITLE_)
         entrytitle _BYLINE_ / textattrs=GRAPHVALUETEXT;
      else
         if (_BYFOOTNOTE_)
            entryfootnote halign=left _BYLINE_;
         endif;
      endif;
   EndGraph;
end;

run;