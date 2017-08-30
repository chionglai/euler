classdef Node
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Value = 0;
    end
    
    properties(Access = protected, Dependent, Hidden)
        Child = []
    end
    
    methods
        function obj = Node(val)
            if (nargin == 1),
                obj.Value = val;
            end;
        end
        
        function obj = set.Value(obj, val)
            obj.Value = val;
        end
        
        function y = get.Value(obj)
            y = obj.Value;
        end
    end
    
end

