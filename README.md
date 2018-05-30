## 项目说明

* 华中Hackathon比赛项目，获得青云企业奖以及深信服企业奖

* 客户端实现手绘，音频录制，拍照等功能

  > 手绘记录第几笔和坐标位置
  >
  > ```objective-c
  > #import "PBDrawView.h"
  > @interface PBDrawView()
  > // 三维数组
  > @property (nonatomic, strong)NSArray<NSMutableArray*> *singLineArray;
  > @end
  > @implementation PBDrawView
  > - (void)drawRect:(CGRect)rect {
  >     [super drawRect:rect];
  >     self.backgroundColor = [UIColor whiteColor];
  >     for (int i = 0; i < self.lineArray.count; i++) {
  >         NSArray<NSMutableArray*> *singleLine = self.lineArray[i];
  >         
  >         for (int j = 0; j < singleLine[0].count-1; j++) {
  >             NSNumber *postionBeginX = singleLine[0][j];
  >             NSNumber *postionBeginY = singleLine[1][j];
  >             NSNumber *postionEndX = singleLine[0][j+1];
  >             NSNumber *postionEndY = singleLine[1][j+1];
  >             
  >             UIBezierPath *bp = [UIBezierPath bezierPath];  // 用于绘图的对象
  >             bp.lineWidth = 2;
  > 
  >             bp.lineCapStyle = kCGLineCapRound;  // 线的形状
  >             
  >             [bp moveToPoint:CGPointMake(postionBeginX.floatValue, postionBeginY.floatValue)  ];  // 将画笔起始点移动到
  >             [bp addLineToPoint:CGPointMake(postionEndX.floatValue, postionEndY.floatValue)];  // 添加直线的另一点
  >             [bp stroke];  // 渲染
  >         }
  >     }
  > }
  > - (instancetype)initWithFrame:(CGRect)frame
  > {
  >     self = [super initWithFrame:frame];
  >     if (self) {
  >         
  >         self.lineArray = [[NSMutableArray alloc] init];
  >         self.backgroundColor = [UIColor whiteColor];
  >     }
  >     return self;
  > }
  > 
  > - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  >     NSMutableArray<NSNumber*> *xArray = [[NSMutableArray alloc] init];
  >     NSMutableArray<NSNumber*> *yArray = [[NSMutableArray alloc] init];
  >     self.singLineArray = @[xArray,yArray];
  >     
  >     NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
  >     UITouch *touch = [allTouches anyObject];   //视图中的所有对象
  >     CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
  >     NSNumber *x = [NSNumber numberWithInt:point.x];
  >     NSNumber *y = [NSNumber numberWithInt:point.y];
  >     [self.singLineArray[0] addObject:x];
  >     [self.singLineArray[1] addObject:y];
  >     [self setNeedsDisplay];
  >     
  > }
  > 
  > - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  >     NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
  >     UITouch *touch = [allTouches anyObject];   //视图中的所有对象
  >     CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
  >     NSNumber *x = [NSNumber numberWithInt:point.x];
  >     NSNumber *y = [NSNumber numberWithInt:point.y];
  >     [self.singLineArray[0] addObject:x];
  >     [self.singLineArray[1] addObject:y];
  >     [self setNeedsDisplay];
  > }
  > 
  > - (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  >     [self.lineArray addObject:self.singLineArray];
  >     [self setNeedsDisplay];
  > }
  > @end
  > 
  > ```
  >
  > 

