function saveCurrentFigure(filename)
box on
saveas(gcf,fullfile(filename + ".fig"));
saveas(gcf,fullfile(filename +".png"));
set(gcf,'Units','Inches');
pos = get(gcf,'Position');
set(gcf,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(gcf,filename +".pdf",'-dpdf','-r500');
end