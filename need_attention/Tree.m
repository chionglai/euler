classdef Tree
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Root
    end
    
    properties(SetAccess = protected)
        Order = ORDER_ASCEND;
    end
    
    properties(Constant)
        ORDER_ASCEND  = 'ascend';
        ORDER_DESCEND = 'descend';
    end
    
    methods
        
        
        function obj = addNode(obj, node)
        end
        
        
        function traversePreOrder(obj)
        end
        
        function traverseInOrder(obj)
        end
        
        function traversePostOrder(obj)
        end
    end
    
end

