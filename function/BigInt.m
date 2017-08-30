classdef BigInt
    %BIGINT Implementation of representing a very large signed integer.
    %   This class is to represent a very large signed integer that is
    %   larger than the system's native integer type. It 
    
    properties(Dependent)
        % This is a dummy properties for getter and setter only. It is not
        % used internally.
         Value
    end
    
    properties(Access = protected, Hidden)
        IntArr
        
        % default is positive (i.e. Sign = 1 or 0). Negative is Sign = -1
        Sign = 1;
        
        % default 1 digit
        NumDigit = BigInt.MinDigit;
        
        Base;
    end
    
    properties(Constant, Hidden)
        % Regular expression pattern for valid integer.
        ValidStrPat = '^-?\d+$';
        
        MinDigit = 1;
        MaxDigit = ceil(log10(double(intmax('int32'))))/2;
    end
    
    methods
        function obj = BigInt(val, varargin)
            % BIGINT Constructor for BigInt class.
            %   val = Signed integer value in string.
            %   numDigit = (Optional) Number of digit per block for
            %       internal representation. The larger the more efficient
            %       the calculation, however, there is an upper limit.
            
            if (nargin > 0),
                nVarargin = length(varargin);
                maxOpt = 1;
                if (nVarargin > maxOpt),
                    error('BigInt:BigInt: At most %d optional inputs', maxOpt);
                end;

                if (nVarargin == 1),
                    if (BigInt.MinDigit <= varargin{1} && varargin{1} <= BigInt.MaxDigit),
                        obj.NumDigit = varargin{1};
                    else
                        error('BigInt:BigInt: Number of digits must be between %d and %d inclusive.', ...
                            BigInt.MinDigit, BigInt.MaxDigit);
                    end;
                    
                end;

                obj.Base = 10^obj.NumDigit;
                obj.Value = val;
            end;
        end
        
        function obj = set.Value(obj, val)
            % SET Method overloading for setting the Value property.
            %   val = Signed integer value in string.
            
            % error checking
            validStr = regexp(val, obj.ValidStrPat, 'match');
            validStr = validStr{1};
            
            if (isempty(validStr)),
                error('BigInt:set.Value:Invalid BigInt input: %s', val);
            end;
            
            if (validStr(1) == '-'),
                obj.Sign = -1;
                validStr(1) = [];
            end;
            
            validStr = vec2mat(validStr, obj.NumDigit);
            
            obj.IntArr = str2num(validStr);
        end
        
        function y = get.Value(obj)
            % GET Method overloading for getting the Value property.
            %    Returned value is the signed integer represented in string.
            
            strFmt = ['%0', num2str(ceil(log10(obj.Base))), 'd'];
            y = sprintf(strFmt, obj.IntArr);
            
            % remove any leading/insignificant zeros
            y = regexprep(y, '^0*', '');
    
            if (obj.Sign == -1),
                y = ['-', y];
            end;
        end
        
        function y = length(obj)
            y = length(obj.IntArr);
        end
        
        function y = getDigit(obj, n)
            len = length(obj);
            
            assert(n > 0, 'BigInt:getLength' ,'Index must be positive.');
            assert((len-n+1) > 0, 'BigInt:getLength' ,'Index exceeds length.');
            
            y = obj.IntArr(end-n+1);
        end
        
        function y = plus(obj, oBigInt)
            % PLUS Method overloading for addition of two BigInt objects.
            %   Perform Y = A + B, where both A and B can be matrix.
            
            [r1, c1] = size(obj);
            [r2, c2] = size(oBigInt);
            
            if (r1 ~= r2 || c1 ~= c2),
                error('BigInt:plus: Matrix dimensions must agree.')
            end;
            
            y(r1, c1) = BigInt;
            for i = 1:r1,
                for j = 1:c1,
                    y(i, j) = BigInt.scalarPlus(obj(i, j), oBigInt(i, j));
                end;
            end;
        end
        
        function y = minus(obj, oBigInt)
            % MINUS Method overloading for subtraction of two BigInt objects.
            %   Perform Y = A - B, where both A and B can be matrix.
            
            [r1, c1] = size(obj);
            [r2, c2] = size(oBigInt);
            
            if (r1 ~= r2 || c1 ~= c2),
                error('BigInt:minus: Matrix dimensions must agree.')
            end;
            
            y(r1, c1) = BigInt;
            for i = 1:r1,
                for j = 1:c1,
                    y(i, j) = BigInt.scalarMinus(obj(i, j), oBigInt(i, j));
                end;
            end;
        end
        
        function y = uminus(obj)
            % UMINUS Method overloading for negation of BigInt object.
            %   Perform Y = -A, where A can be matrix.
            
            [row, col] = size(obj);
            
            y(row, col) = BigInt;
            for i = 1:row,
                for j = 1:col,
                    y(i, j) = obj(i, j);
                    y(i, j).Sign = -y(i, j).Sign;
                end;
            end;
        end
        
        function y = times(obj, oBigInt)
            % TIMES Method overloading for element-wise multiplication of
            % two BigInt objects.
            %   Perform Y = A .* B, where both A and B can be matrix.
            
            [r1, c1] = size(obj);
            [r2, c2] = size(oBigInt);
            
            if (~isscalar(obj) && ~isscalar(oBigInt)),
                if (r1 ~= r2 || c1 ~= c2),
                    error('BigInt:times: Matrix dimensions must agree.');
                end;
                
                y(r1, c1) = BigInt;
                for i = 1:r1,
                    for j = 1:c1,
                        y(i, j) = BigInt.scalarTimes(obj(i, j), oBigInt(i, j));
                    end;
                end;
            else
                if (isscalar(oBigInt)),
                    r2 = r1;
                    c2 = c1;
                    
                    temp = obj;
                    obj = oBigInt;
                    oBigInt = temp;
                end;
                
                % at this point, obj will be scalar, and oBigInt will be
                % matrix, with its dimensions given by [r1, c1]
                y(r2, c2) = BigInt;
                for i = 1:r2,
                    for j = 1:c2,
                        y(i, j) = BigInt.scalarTimes(obj, oBigInt(i, j));
                    end;
                end;
            end;    
        end
        
        function y = mtimes(obj, oBigInt)
            % MTIMES Method overloading for matrix multiplication of two
            % BigInt objects.
            %   Perform Y = A * B, where both A and B can be matrix.
            
            if (isscalar(obj) || isscalar(oBigInt)),
                y = obj .* oBigInt;
            else
                [r1, c1] = size(obj);
                [r2, c2] = size(oBigInt);

                if (c1 ~= r2),
                    error('BigInt:mtimes: Inner matrix dimensions must agree.')
                end;

                y(r1, c2) = BigInt;
                for i = 1:r1,
                    for j = 1:c2,
                        temp = obj(i, :) .* oBigInt(:, j).';
                        y(i, j) = BigInt.sum(temp);
                    end;
                end;
            end;
        end
        
        function [y, rem] = rdivide(obj, oBigInt)
           error('Not implemented yet'); 
        end
        
        function [y, rem] = mrdivide(obj, oBigInt)
           error('Not implemented yet'); 
        end
        
        function y = power(obj, val)
            % POWER Method overloading for element-wise power of BigInt
            % objects.
            %   Perform Y = A .^ B, where both A and B can be matrix.
            %   However, only A can be BigInt objects, and B must be native
            %   non-negative integer.
            
            if (isa(val, 'BigInt')),
                error('BigInt:power: BigInt object as exponent is not supported yet.');
            end;
            
            if (sum(sum(val < 0))),
                error('BigInt:power: Negative exponent is not supported yet.')
            end;
            
            [r1, c1] = size(obj);
            [r2, c2] = size(val);
            
            if (~isscalar(obj) && ~isscalar(val)),
                if (r1 ~= r2 || c1 ~= c2),
                    error('BigInt:power: Matrix dimensions must agree.');
                end;
                
                y(r1, c1) = BigInt;
                for i = 1:r1,
                    for j = 1:c1,
                        y(i, j) = BigInt.scalarPower(obj(i, j), val(i, j));
                    end;
                end;
            elseif (isscalar(val)),
                y(r2, c2) = BigInt;
                for i = 1:r2,
                    for j = 1:c2,
                        y(i, j) = BigInt.scalarPower(obj(i, j), val);
                    end;
                end;
            else
                y(r2, c2) = BigInt;
                for i = 1:r2,
                    for j = 1:c2,
                        y(i, j) = BigInt.scalarPower(obj, val(i, j));
                    end;
                end;
            end;
        end
        
        function y = mpower(obj, val)
            if (isscalar(obj) && isscalar(val)),
                y = obj .^ val;
            else
                error('BigInt:mpower: Only both scalar base and scalar exponent is currently supported for mpower.');
            end;
        end
    end
    
    methods(Static)
        function y = sparse(m, n)
           y(m, n) = BigInt; 
        end
        
        function y = sum(objArr, dim)
            if (isscalar(objArr)),
                % do nothing
                return;
            end;
    
            [row, col] = size(objArr);
            if (~isvector(objArr)),
                if (nargin == 2 && dim == 2),
                    y = BigInt.sparse(row, 1);
                    objArr = objArr.';
                else
                    y = BigInt.sparse(1, col);
                end
            elseif (nargin == 1 ||  ... % objArr is a vector and dim is not specified
                    (iscolumn(objArr) && dim == 1) || ... 
                    (isrow(objArr)    && dim == 2)),
                y = BigInt;
                objArr = objArr(:);
            end;
            
            [row, col] = size(objArr);
            for j = 1:col,
                yj = BigInt('0');
                for i = 1:row,
                    yj = yj + objArr(i, j);
                end;
                
                y(j) = yj;
            end;
        end
    end
    
    methods(Static, Hidden)
        function y = scalarPlus(obj, oBigInt)
            % SCALARPLUS Addition of two BigInt object scalars.
            %   Perform y = a + b, where a and b are both BigInt object
            %   scalars. The return object y is a newly created BigInt
            %   object containing the addition result.
            
            if (obj.Sign * oBigInt.Sign > 0),
                % Addition of both positive or both negative number
                objLen = length(obj.IntArr);
                oBigIntLen = length(oBigInt.IntArr);
                
                tempArr = zeros(max(objLen, oBigIntLen), 1);
                tempArr((end-objLen+1):end) = obj.IntArr;
                tempArr((end-oBigIntLen+1):end) = tempArr((end-oBigIntLen+1):end) + oBigInt.IntArr;
                
                tempArr = BigInt.correctDigit(tempArr, obj.Base);
                
                y = BigInt('0');
                y.IntArr = tempArr;
                y.Sign = obj.Sign;
            elseif (obj.Sign > oBigInt.Sign),
                % minus, obj > oBigInt
                y = obj - (-oBigInt);
            else
                % minus, oBigInt > obj
                y = oBigInt - (-obj);
            end;
        end
        
        function y = scalarMinus(obj, oBigInt)
            % SCALARMINUS Addition of two BigInt object scalars.
            %   Perform y = a - b, where a and b are both BigInt object
            %   scalars. The return object y is a newly created BigInt
            %   object containing the addition result.
            
            if (obj.Sign * (-oBigInt.Sign) > 0),
                y = obj + (-oBigInt);
            else
                % Addition of both positive or both negative number
                objLen = length(obj.IntArr);
                oBigIntLen = length(oBigInt.IntArr);
                
                tempArr = zeros(max(objLen, oBigIntLen), 1);
                tempArr((end-objLen+1):end) = obj.IntArr;
                tempArr((end-oBigIntLen+1):end) = tempArr((end-oBigIntLen+1):end) - oBigInt.IntArr;
                
                [tempArr, carry] = BigInt.correctDigit(tempArr, obj.Base);
                
                y = BigInt('0');
                y.IntArr = tempArr;
                y.Sign = carry;
            end;
        end
        
        function y = scalarTimes(obj, oBigInt)
            % SCALARTIMES Addition of two BigInt object scalars.
            %   Perform y = a * b, where a and b are both BigInt object
            %   scalars. The return object y is a newly created BigInt
            %   object containing the addition result.
            
            tempArr = conv(obj.IntArr, oBigInt.IntArr);
            tempArr = BigInt.correctDigit(tempArr, obj.Base);
            
            y = BigInt('0');
            y.IntArr = tempArr;
            y.Sign = obj.Sign * oBigInt.Sign;
        end
        
        function y = scalarPower(obj, val)
            % val must be non-negative
            assert(val >= 0);
            
            if (val == 0),
                y = BigInt('0');
            elseif (val == 1),
                y = obj;
            else
                y = BigInt('1');
                while(val > 1),
                    nRecur = floor(log2(val));
                    yPowMulti2 = BigInt.recurTimes(obj, nRecur);
                    y = BigInt.scalarTimes(y, yPowMulti2);
                    
                    val = val - 2^nRecur;
                end;
                
                % val will be either 0 or 1
                if (val == 1),
                    y = BigInt.scalarTimes(y, obj);
                end;
            end;
        end
        
        function y = recurTimes(obj, N)
            y = obj;
            for i = 1:N,
                y = BigInt.scalarTimes(y, y);
            end;
        end
        
        function [y, carry] = correctDigit(x, base)
            % CORRECTDIGIT Summary of this function goes here
            %   Detailed explanation goes here

            base = double(base);
            
            carry = 0;
            for i = length(x):-1:1,
                carry = floor(carry/base) + x(i);
                x(i) = mod(carry, base);
            end;
            carry = floor(carry/base);

            % if negative, apply 10's complement
            if (carry < 0),
                % find the last non-zero digit just before the trailing zeros
                idx = find(x, 1, 'last');

                % apply 10's complement
                x(1:(idx-1)) = (base - 1) - x(1:(idx-1));
                x(idx) = base - x(idx);
                
                y = x;
            elseif (carry > 0),
                y = [BigInt.int2dig(carry, base); x(:)];
            else    % carry == 0
                y = x;
            end;
        end
        
        function y = int2dig(x, base)
            % add checking, x positive

            %UNTITLED5 Summary of this function goes here
            %   Detailed explanation goes here

            if (x < 0),
                error('Error: x must be positive.');
            elseif (x < 2),
                y = x;
            else
                N = ceil(log10(x)/log10(base));

                y = zeros(1, N);
                temp = x;
                for i = 1:N,
                    y(end-i+1) = mod(temp, base);

                    temp = floor(temp/base);
                end;
            end;
        end
    end
end

